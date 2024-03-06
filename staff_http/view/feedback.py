from flask import Blueprint
from extension import db
from models import Feedback,Staff,Admin_user
from flask import jsonify
from flask import request
from until import getDate
from flask_jwt_extended import get_jwt_identity, jwt_required
from setting import redis_client

feedback = Blueprint('feedback',__name__)

# 发送反馈内容
# 接收的Post格式
"""
{
    # 发送方员工ID
    send_staffId,
    # 反馈内容
    content
}
"""
@feedback.route('/feedback/feedbackPost',methods=['POST'])
def feedbackPost():
    try:
        # 获取post数据
        send_staffId = request.json.get('send_staffId')
        content = request.json.get('content')

        # 查找是否有该用户
        staff = Staff.query.filter(Staff.staffId == send_staffId).first(),
        if staff[0] == None:
            # 用户不存在
            return jsonify({           
                #返回状态码
                "code": 401,
                #返回信息描述
                "message": "员工号错误，请确认员工号是否正确",
                #返回值
                "data": {}
            })
        msg = Feedback(send_staffId = send_staffId, content = content, dateTime = getDate())
        db.session.add_all([msg])
        db.session.commit()
        # 返回体
        return jsonify({
            #返回状态码
            "code": 200,
            #返回信息描述
            "message": "提交成功，稍后管理员会进行处理",
            #返回值
            "data": ""
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
@feedback.route('/feedback/filterAll',methods=['GET'])
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
        feedback = userData.schema()["authority"].find("feedback")
        if feedback != -1:
            # 查询出所有数据
            queryData = Feedback.query.order_by(Feedback.dateTime)
            # 时间区域查找
            if (startTime != None) and (endTime != None and endTime != ""):
                queryData = queryData.filter(Feedback.dateTime.between(startTime, endTime))
            # 关键字查找
            if searchText != None and searchText != "":
                queryData = queryData.filter(Feedback.content.like("%" + searchText + "%"))
            # 分页
            pn = queryData.paginate(page=int(pageNo), per_page= 15, error_out=False)
            # 添加到dataList
            for item in pn:
                dataList.append({
                    "id":item.schema()["id"],
                    "content":item.schema()["content"],
                    "send_staffId":item.schema()["send_staffId"],
                    "dateTime":item.schema()["dateTime"],
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
    


