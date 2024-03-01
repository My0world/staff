from flask import Blueprint
from models import Admin_op_record,Admin_user
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from setting import redis_client

admin_op_record = Blueprint('admin_op_record',__name__)

# 筛选出所有数据
# GET
# 接收的GET格式
"""
    # 开始时间
    startTime
    # 结束时间
    endTime
    # 搜索关键字
    searchText
    # 页码
    pageNo
"""
@admin_op_record.route('/admin_op_record/filterAll',methods=['GET'])
@jwt_required()
def queryAll():
    dataList = []
    try:
        # 身份验证
        userid = get_jwt_identity()
        # 开始时间
        startTime = request.args.get("startTime")
        # 开始时间
        endTime = request.args.get("endTime")
        # 搜索关键字
        searchText = request.args.get("searchText")
        # 页码
        pageNo = request.args.get("pageNo")
        # 是否登录了
        if userid == None:
            return jsonify({           
                #返回状态码
                "code": 401,
                #返回信息描述
                "message": "请登录",
                #返回值
                "data": {}
            })
        # 获取header的token
        headerToken = request.headers['Authorization'].split('Bearer ')[1]
        # 获取redis的token
        token = redis_client.get(userid)
        # 判断token是否存在并且和头部的token是否一致
        if not token or token.decode() != headerToken:
            # 返回体
            return jsonify({
            #返回状态码
                "code": 401,
                #返回信息描述
                "message": "身份已过期，请重新登录",
                #返回值
                "data": {}
            }) 
        # 查找权限
        userData = Admin_user.query.filter(Admin_user.staffId == userid).first()
        operatingData = userData.schema()["authority"].find("operatingData")
        if operatingData != -1:
            # 查询出所有数据
            queryData = Admin_op_record.query.order_by(Admin_op_record.datetime)
            # 时间区域查找
            if (startTime != None) and (endTime != None and endTime != ""):
                queryData = queryData.filter(Admin_op_record.datetime.between(startTime, endTime))
            # 关键字查找
            if searchText != None and searchText != "":
                queryData = queryData.filter(Admin_op_record.content.like("%" + searchText + "%"))
            # 分页
            pn = queryData.paginate(page=int(pageNo), per_page=7, error_out=False)
            # 添加到dataList
            for item in pn:
                dataList.append({
                    "id":item.schema()["id"],
                    "content":item.schema()["content"],
                    "staffId":item.schema()["staffId"],
                    "datetime":item.schema()["datetime"],
                })
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "成功",
                #返回值
                "data": {
                    "total":pn.total,
                    'data':dataList
                }
        })  
        # 返回体
        return jsonify({
            #返回状态码
            "code": 403,
            #返回信息描述
            "message": "你没有权限",
            #返回值
            "data": {}
        })
    except:
        # 返回体
        return jsonify({
            #返回状态码
            "code": 500,
            #返回信息描述
            "message": "内部服务器错误",
            #返回值
            "data": {}
        })
    