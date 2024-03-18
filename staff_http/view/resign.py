from flask import Blueprint
from extension import db
from models import Staff,Admin_op_record,Admin_user,Resign,Department
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from until import getDate
from setting import redis_client


resign = Blueprint('resign',__name__)


# 添加离职员工数据
# POST
# 接收的Post格式
"""
{
    # 部门
    departId,
    # 员工姓名
    staffName,
    # 员工ID
    staffId,
    # 职位
    job,
    #手机号码
    phoneNum
    # 性别
    sex,
    # 年龄(区间)
    age,
    # 薪资(区间)
    salary,
    # 加入公司的时间(区间)
    entryTime
}
"""
@resign.route('/resign/resignStaff',methods=['POST'])
@jwt_required()
def resignStaff():
    try:
        userid = get_jwt_identity()
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
        # 查找用户
        user = Admin_user.query.filter(Admin_user.staffId == userid).first(),
        # 查找权限
        settingDimission = user[0].schema()["authority"].find("settingDimission")
        staffId = request.json.get('staffId')
        departId = request.json.get('departId')
        staffName = request.json.get('staffName')
        job = request.json.get('job')
        phoneNum = request.json.get('phoneNum')
        sex = request.json.get('sex')
        age = request.json.get('age')
        salary = request.json.get('salary')
        entryTime = request.json.get('entryTime')
        # 对权限进行判断
        if settingDimission != -1:    
            record = f'<div class="shortMsg">{userid}将{staffName}设置为离职</div>'
            # 向离职员工表添加信息
            resign = Resign(staffId = staffId, departId = departId, phoneNum = phoneNum, staffName = staffName, sex = sex, age = age, salary = salary ,job = job ,entryTime = entryTime ,resignTime = getDate())
            # 向操作记录表添加信息
            msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
            # 删除员工表
            Staff.query.filter(Staff.staffId == staffId).delete()
            # 如果用户表存在就删除用户表
            if Admin_user.query.filter(Admin_user.staffId == staffId).first() != None:
                Admin_user.query.filter(Staff.staffId == staffId).delete()
            db.session.add_all([resign,msg])
            db.session.commit()
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "设置成功",
                #返回值
                "data": {}
            })
        else:
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
    


# 筛选所有离职员工数据
# POST
# 接收的Post格式
"""
{
    # 部门
    departId,
    # 性别
    sex,
    # 职位
    job,
    # 年龄(区间)
    (startAge-endAge),
    # 离职公司的时间(区间)
    (startResignTime-endResignTime),
    # 搜索关键字
    searchValue:"",
    # 页码
    pageNo,
    # 一页显示多少条
    pageSize
}
"""
@resign.route('/resign/filterAll',methods=['POST'])
@jwt_required()
def filterAll():
    dataList = []
    try:
        userid = get_jwt_identity()
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
        # 获取Post数据
        departId = request.json.get('departId')
        sex = request.json.get('sex')
        job = request.json.get('job')
        startAge = request.json.get('startAge')
        endAge = request.json.get('endAge')
        startResignTime = request.json.get('startResignTime')
        endResignTime = request.json.get('endResignTime')
        searchValue = request.json.get('searchValue')
        pageNo = request.json.get('pageNo')
        pageSize = request.json.get('pageSize')
        # 查询出所有数据
        queryData = Resign.query.order_by(Resign.resignTime)
        # 查找权限
        userData = Admin_user.query.filter(Admin_user.staffId == userid).first()
        dimissionData = userData.schema()["authority"].find("dimissionData")
        # 有查看所有员工信息的权限
        if dimissionData != -1:
            # 对查询出的数据筛选
            if departId != None  and departId != "":
                queryData = queryData.filter(Resign.departId == departId)
            if sex != None and sex != "":
                queryData = queryData.filter(Resign.sex == sex)
            if job != None and job != "":
                queryData = queryData.filter(Resign.job == job)
            if (startAge != None and endAge != None) and (endAge != 0):
                queryData = queryData.filter(Resign.age.between(startAge, endAge))
            if (startResignTime != None) and (endResignTime != None and endResignTime != ""):
                queryData = queryData.filter(Resign.resignTime.between(startResignTime, endResignTime))
            if searchValue != None and searchValue != "":
                queryData = queryData.filter(Resign.staffName.like("%" + searchValue + "%"))
            if pageNo == None and pageSize == None:
                pageNo = 1
                pageSize = 7
            # 分页
            pn = queryData.paginate(page=pageNo, per_page=pageSize, error_out=False)
            # 添加到dataList
            for item in pn.items:
                dataList.append({
                    "staffId":item.schema()["staffId"],
                    "departId":item.schema()["departId"],
                    "departName":Department.query.filter(Department.departId == item.schema()["departId"]).first().schema()["department_Name"],
                    "phoneNum":item.schema()["phoneNum"],
                    "staffName":item.schema()["staffName"],
                    "sex":item.schema()["sex"],
                    "age":item.schema()["age"],
                    "salary":item.schema()["salary"],
                    "job":item.schema()["job"],
                    "entryTime":item.schema()["entryTime"],
                    "resignTime":item.schema()["resignTime"],
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
        else:
            # 对查询出的数据筛选
            userStaffData = Resign.query.filter(Resign.staffId == userid).first()
            if userStaffData == None:
                # 返回体
                return jsonify({
                    #返回状态码
                    "code": 401,
                    #返回信息描述
                    "message": "请确认你所在的部门是否存在",
                    #返回值
                    "data": {}
                })
            departId = userStaffData.schema()["departId"]
            queryData = queryData.filter(Resign.departId == departId).order_by(Resign.entryTime)
            if sex != None and sex != "":
                queryData = queryData.filter(Resign.sex == sex)
            if job != None and job != "":
                queryData = queryData.filter(Resign.job == job)
            if (startAge != None and endAge != None) and (endAge != 0):
                queryData = queryData.filter(Resign.age.between(startAge, endAge))
            if (startResignTime != None) and (startResignTime != None and endResignTime != ""):
                queryData = queryData.filter(Resign.resignTime.between(startResignTime, endResignTime))
            if searchValue != None and searchValue != "":
                queryData = queryData.filter(Resign.staffName.like("%" + searchValue + "%"))
            if pageNo == None and pageSize == None:
                pageNo = 1
                pageSize = 8
            # 分页
            pn = queryData.paginate(page=pageNo, per_page=pageSize, error_out=False)
            # 添加到dataList
            for item in pn.items:
                dataList.append({
                    "staffId":item.schema()["staffId"],
                    "departId":item.schema()["departId"],
                    "departName":Department.query.filter(Department.departId == item.schema()["departId"]).first().schema()["department_Name"],
                    "phoneNum":item.schema()["phoneNum"],
                    "staffName":item.schema()["staffName"],
                    "sex":item.schema()["sex"],
                    "age":item.schema()["age"],
                    "salary":item.schema()["salary"],
                    "job":item.schema()["job"],
                    "entryTime":item.schema()["entryTime"],
                    "resignTime":item.schema()["resignTime"],
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
    


# 添加回员工表
# GET
# 接收的Post格式
"""
    # 离职员工id
    resignStaffId
"""
@resign.route('/resign/returnStaff',methods=['GET'])
@jwt_required()
def returnStaff():
    try:
        userid = get_jwt_identity()
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
        # 查找用户
        user = Admin_user.query.filter(Admin_user.staffId == userid).first()
        # 查找权限
        returnStaffTable = user.schema()["authority"].find("returnStaffTable")
        # 获取GET数据
        # 离职员工ID
        resignStaffId = request.args.get("resignStaffId")
        # 对权限进行判断
        if returnStaffTable != -1:
            # 获取离职员工信息
            resignStaff = Resign.query.filter(Resign.staffId == resignStaffId).first()
            if resignStaff == None:
                # 返回体
                return jsonify({
                    #返回状态码
                    "code": 401,
                    #返回信息描述
                    "message": "离职员工中没有这位员工哦",
                    #返回值
                    "data": {}
                })
            record = f'<div class="shortMsg">{userid}将{resignStaffId}从离职员工移到了正式员工中</div>'
            # 向员工表添加信息
            staff = Staff(
                staffId = resignStaff.schema()["staffId"], 
                departId = resignStaff.schema()["departId"], 
                phoneNum = resignStaff.schema()["phoneNum"], 
                staffName = resignStaff.schema()["staffName"], 
                sex = resignStaff.schema()["sex"], 
                age = resignStaff.schema()["age"], 
                salary = resignStaff.schema()["salary"] ,
                job = resignStaff.schema()["job"] ,
                entryTime = resignStaff.schema()["entryTime"]
            )
            # 向操作记录表添加信息
            msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
            Resign.query.filter(Resign.staffId == resignStaffId).delete()
            db.session.add_all([staff,msg])
            db.session.commit()
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "移动成功",
                #返回值
                "data": {}
            })
        else:
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