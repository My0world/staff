from flask import Blueprint
from extension import db
from models import Askforleave,Admin_user,Workattendance,Department
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from sqlalchemy import and_
from setting import redis_client
from datetime import datetime, timedelta
import json

askforleave = Blueprint('askforleave',__name__)

# 查询所有考勤
# POST
# 接收的Post格式
"""
{
    # 部门
    departId,
    # 状态
    status,
    # 页码
    pageNo
    # 搜索关键字
    searchValue,
    # 日期
    dateTime
    # 页码
    pageNo,
    # 一页显示多少条
    pageSize

}
"""
@askforleave.route('/askforleave/queryAll',methods=['POST'])
@jwt_required()
def queryAll():
    dataList = []
    try:
        # 页码
        pageNo = request.json.get("pageNo")
        # 一页显示多少条
        pageSize = request.json.get("pageSize")
        # 搜索关键字
        searchValue = request.json.get("searchValue")
        # 日期
        dateTime = request.json.get("dateTime")
        # 状态
        status = request.json.get("status")
        # 部门
        departId = request.json.get("departId")
        # 员工ID
        staffId = request.json.get("staffId")
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
        # 查找权限
        userData = Admin_user.query.filter(Admin_user.staffId == userid).first()
        allCheckingIn = userData.schema()["authority"].find("allCheckingIn")
        departmentCheckingIn = userData.schema()["authority"].find("departmentCheckingIn")
        # 所有考勤
        if allCheckingIn != -1:
            print(123)
            # 查询用户表所有数据
            queryData = Askforleave.query.filter_by()
            # 员工ID
            if staffId != None and staffId != "":
                queryData = queryData.filter(Askforleave.staffId == staffId)
            # 部门查找
            if departId != None and departId != "":
                queryData = queryData.filter(Askforleave.departId == departId)
            # 日期查找
            if dateTime != None and dateTime != "":
                queryData = queryData.filter(Askforleave.startTime == dateTime)
            # 状态查找
            if status != None and status != "":
                queryData = queryData.filter(Askforleave.status == status)
            # 关键字查找
            if searchValue != None and searchValue != "":
                queryData = queryData.filter(Askforleave.staffName.like("%" + searchValue + "%"))
             # 分页
            if pageSize != None and pageSize != "":
                pn = queryData.paginate(page=int(pageNo), per_page=pageSize, error_out=False)
                total = pn.total
            else:
                pn = queryData
                total = 0
            # 添加到dataList
            for item in pn:
                dataList.append({
                    "id":item.schema()["id"],
                    "staffId":item.schema()["staffId"],
                    "staffName":item.schema()["staffName"],
                    "departName":Department.query.filter(Department.departId == item.schema()["departId"]).first().schema()["department_Name"],
                    "content":item.schema()["content"],
                    "startTime":item.schema()["startTime"].strftime('%Y-%m-%d'),
                    "endTime":item.schema()["endTime"].strftime('%Y-%m-%d'),
                    "dateTime":item.schema()["dateTime"],
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
                    "total":total,
                    'data':dataList
                }
            }) 
        elif departmentCheckingIn != -1:
            # 查询用户表所有数据
            queryData = Askforleave.query.filter_by()
            # 部门查找
            myDepartId = userData.schema()["departId"]
            queryData = queryData.filter(Askforleave.departId == myDepartId)
            # 员工ID
            if staffId != None and staffId != "":
                queryData = queryData.filter(Askforleave.staffId == staffId)
            # 日期查找
            if dateTime != None and dateTime != "":
                queryData = queryData.filter(Askforleave.startTime == dateTime)
            # 状态查找
            if status != None and status != "":
                queryData = queryData.filter(Askforleave.status == status)
            # 关键字查找
            if searchValue != None and searchValue != "":
                queryData = queryData.filter(Askforleave.staffName.like("%" + searchValue + "%"))
             # 分页
            if pageSize != None and pageSize != "":
                pn = queryData.paginate(page=int(pageNo), per_page=pageSize, error_out=False)
                total = pn.total
            else:
                pn = queryData
                total = 0
            # 添加到dataList
            for item in pn:
                dataList.append({
                    "id":item.schema()["id"],
                    "staffId":item.schema()["staffId"],
                    "staffName":item.schema()["staffName"],
                    "departName":Department.query.filter(Department.departId == item.schema()["departId"]).first().schema()["department_Name"],
                    "content":item.schema()["content"],
                    "startTime":item.schema()["startTime"].strftime('%Y-%m-%d'),
                    "endTime":item.schema()["endTime"].strftime('%Y-%m-%d'),
                    "dateTime":item.schema()["dateTime"],
                    "status":item.schema()["status"],
                })
            print(dataList)
            # 返回体
            return jsonify({
            #返回状态码
                "code": 200,
                #返回信息描述
                "message": "成功",
                #返回值
                "data": {
                    "total":total,
                    'data':dataList
                }
            }) 
        else:
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
    
# 审核
# POST
# 接收的GET格式
"""
{
    # 操作内容Id
    opid
    # 员工ID
    staffId,
    # 状态
    status
}
"""
@askforleave.route('/askforleave/updateStatus',methods=['GET'])
@jwt_required()
def updateStatus():
    # try:
        userid = get_jwt_identity()
        opid = request.args.get("opid")
        status = request.args.get('status')
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
        checkVacate = userData.schema()["authority"].find("checkVacate")
        if checkVacate != -1:
            if status == '审核通过':
                # 审核修改
                afl = Askforleave.query.filter(Askforleave.id == opid).first()
                # 获取请假的天数
                start_date = datetime.strptime(afl.schema()["startTime"].strftime('%Y-%m-%d'), "%Y-%m-%d")
                end_date = datetime.strptime(afl.schema()["endTime"].strftime('%Y-%m-%d'), "%Y-%m-%d")
                date_range = []
                current_date = start_date
                while current_date <= end_date:
                    date_range.append(current_date)
                    current_date += timedelta(days=1)
                # 查找请假的天数
                addafl = []
                for date in date_range:
                    wae = Workattendance.query.filter(and_(Workattendance.staffId == afl.schema()["staffId"],Workattendance.date == date)).first()
                    if(wae == None):
                        addafl.append(
                            Workattendance(staffId = afl.schema()["staffId"], staffName = afl.schema()["staffName"], date = date, startTime = "", endTime = "", status = "请假", departId = afl.schema()["departId"])
                        )
                    else:
                        wae.status = "请假"
                        wae.startTime = ""
                        wae.endTime = ""
                # 如果为空不添加        
                if(len(addafl) != 0):
                    db.session.add_all(addafl)
                afl.status = "审核通过"
                db.session.commit()
                # 返回体
                return jsonify({
                    #返回状态码
                    "code": 200,
                    #返回信息描述
                    "message": status,
                    #返回值
                    "data": {}
                })
            elif status == '审核驳回':
                # 审核修改
                Askforleave.query.filter(Askforleave.id == opid).update({'status': status})
                db.session.commit()
                # 返回体
                return jsonify({
                    #返回状态码
                    "code": 200,
                    #返回信息描述
                    "message": status,
                    #返回值
                    "data": {}
                })
            else:
                return jsonify({
                    #返回状态码
                    "code": 400,
                    #返回信息描述
                    "message": "状态不正确",
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
    # except:
    #     # 返回体
    #     return jsonify({
    #         #返回状态码
    #         "code": 500,
    #         #返回信息描述
    #         "message": "内部服务器错误",
    #         #返回值
    #         "data": {}
    #     })