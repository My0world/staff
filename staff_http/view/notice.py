from flask import Blueprint
from extension import db
from models import Admin_user,Notice,Department
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from until import getDate
from setting import redis_client
import json

notice = Blueprint('notice',__name__)

# 发布通知
# POST
# 接收的Post格式
"""
{
    # 部门ID
    departId,
    # 标题
    title,
    # 内容
    content
}
"""
@notice.route('/notice/issue',methods=['POST'])
@jwt_required()
def issue():
    try:
        # 身份验证
        userid = get_jwt_identity()
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
        # 获取post数据
        departId = request.json.get('departId')
        title = request.json.get('title')
        content = request.json.get('content')
        # 发布通知
        msg = Notice(title = title, send_staffId = userid, receiver_departIds = departId, content = content,datetime = getDate())
        db.session.add_all([msg])
        db.session.commit()
        # 返回体
        return jsonify({           
            #返回状态码
            "code": 200,
            #返回信息描述
            "message": "发布成功",
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



# 获取已发送的
# GET
# 接收的GET格式
"""
    # 搜索内容
    searchText,
    # 页码
    pageNo,
"""
@notice.route('/notice/send',methods=['GET'])
@jwt_required()
def send():
    dataList = []
    try:
        # 身份验证
        userid = get_jwt_identity()
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
        # 查询出所有数据
        queryData = Notice.query.filter(Notice.send_staffId == userid).order_by(-Notice.datetime)
        if searchText != None and searchText != "":
            queryData = queryData.filter(Notice.content.like("%" + searchText + "%"))
        # 分页
        pn = queryData.paginate(page=int(pageNo), per_page=12, error_out=False)
        # 添加到dataList
        for item in pn:
            departNames = []
            dIds = item.schema()['receiver_departIds'].split(",")
            for citem in dIds:
                departNames.append(Department.query.filter(Department.departId == citem).first().schema()["department_Name"])
            dataList.append({
                "id":item.schema()["id"],
                "title":item.schema()["title"],
                "content":item.schema()["content"],
                "datetime":item.schema()["datetime"],
                "departName":",".join(departNames),
                "send_staffName": Admin_user.query.filter(Admin_user.staffId == item.schema()["send_staffId"]).first().schema()["staffName"],
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


# 获取已发送的
# GET
# 接收的GET格式
"""
    # 搜索内容
    searchText,
    # 页码
    pageNo,
"""
@notice.route('/notice/receiver',methods=['GET'])
@jwt_required()
def receiver():
    dataList = []
    try:
        # 身份验证
        userid = get_jwt_identity()
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
        # 查询出所有数据
        userDid = Admin_user.query.filter(Admin_user.staffId == userid).first().schema()["departId"]
        queryData = Notice.query.filter(Notice.receiver_departIds.like("%" + userDid + "%")).order_by(-Notice.datetime)
        if searchText != None and searchText != "":
            queryData = queryData.filter(Notice.content.like("%" + searchText + "%"))
        # 分页
        pn = queryData.paginate(page=int(pageNo), per_page=12, error_out=False)
        # 添加到dataList
        for item in pn:
            departNames = []
            dIds = item.schema()['receiver_departIds'].split(",")
            for citem in dIds:
                departNames.append(Department.query.filter(Department.departId == citem).first().schema()["department_Name"])
            dataList.append({
                "id":item.schema()["id"],
                "title":item.schema()["title"],
                "content":item.schema()["content"],
                "datetime":item.schema()["datetime"],
                "departName":",".join(departNames),
                "send_staffName": Admin_user.query.filter(Admin_user.staffId == item.schema()["send_staffId"]).first().schema()["staffName"],
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
    