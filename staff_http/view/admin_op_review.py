from flask import Blueprint
from models import Admin_op_review,Admin_op_record,Admin_user
from flask import jsonify
from extension import db
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from setting import redis_client
from until import getDate

admin_op_review = Blueprint('admin_op_review',__name__)

# 筛选出所有数据
# GET
# 接收的GET格式
"""
    # 状态
    status(待审核、审核通过、审核驳回)
    # 页码
    pageNo
"""
@admin_op_review.route('/admin_op_review/filterAll',methods=['GET'])
@jwt_required()
def queryAll():
    dataList = []
    try:
        # 身份验证
        userid = get_jwt_identity()
        # 操作内容请求状态
        status = request.args.get("status")
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
        operatingRequestAudit = userData.schema()["authority"].find("operatingRequestAudit")
        if operatingRequestAudit != -1:
            # 查询操作内容审核表所有数据
            if status == "全部" or status == "" or status == None:
                queryData = Admin_op_review.query.filter_by()
            else:
                queryData = Admin_op_review.query.filter(Admin_op_review.status == status)
            # 分页
            pn = queryData.paginate(page=int(pageNo), per_page=8, error_out=False)
            # 添加到dataList
            for item in pn:
                dataList.append({
                    "id":item.schema()["id"],
                    "data":item.schema()["data"],
                    "description":item.schema()["description"],
                    "staffId":item.schema()["staffId"],
                    "staffName": Admin_user.query.filter(Admin_user.staffId == item.schema()["staffId"]).first().schema()["staffName"],
                    "datetime":item.schema()["datetime"],
                    "status":item.schema()["status"],
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
    

# 审核驳回
# GET
# 接收的GET格式
"""
    # 操作内容id
    id
"""
@admin_op_review.route('/admin_op_review/checkReject',methods=['GET'])
@jwt_required()
def checkReject():
    try:
        userid = get_jwt_identity()
        id = request.args.get("id")
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
        updateOpReviewStatus = userData.schema()["authority"].find("updateOpReviewStatus")
        if updateOpReviewStatus != -1:
            # 审核修改
            # 其他用户的操作审核通过
            Admin_op_review.query.filter(Admin_op_review.id == id).update({'status': "审核驳回"})
            queryData = Admin_op_review.query.filter(Admin_op_review.id == id)
            # 记下操作记录
            record = f'<div class="shortMsg">{queryData[0].schema()["staffId"]}用户的操作请求编号为{id}已被{userid}用户驳回</div>'
            # 向操作记录表添加信息
            msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
            db.session.add_all([msg])
            db.session.commit()
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "审核驳回",
                #返回值
                "data": {}
            })
        # 返回体
        return jsonify({
            #返回状态码
            "code": 401,
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