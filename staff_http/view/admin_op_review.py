from flask import Blueprint
from extension import db
from models import Admin_op_review
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from setting import redis_client
import json

admin_op_review = Blueprint('admin_op_review',__name__)

# 查询出所有数据
@admin_op_review.route('/admin_op_review/filterAll',methods=['GET'])
@jwt_required()
def queryAll():
    dataList = []
    try:
        userid = get_jwt_identity()
        status = request.args.get("status")
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
        # 查询操作内容审核表所有数据
        if status == "全部":
            queryData = Admin_op_review.query.filter_by()
        else:
            queryData = Admin_op_review.query.filter_by(status == status)
        # 分页
        pn = queryData.paginate(page=pageNo, per_page=7, error_out=False)
        # 添加到dataList
        for item in pn:
            dataList.append({
                "id":item.schema()["id"],
                "data":item.schema()["data"],
                "description":item.schema()["description"],
                "staffId":item.schema()["staffId"],
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
                "count":len(dataList),
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