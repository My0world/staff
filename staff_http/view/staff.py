from flask import Blueprint
from extension import db
from models import Staff,Department,Admin_op_record,Admin_user,Admin_op_review,Resign
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from until import getDate
from setting import redis_client
import json


staff = Blueprint('staff',__name__)

# 重置数据
@staff.route('/staff/resetData',methods=['GET'])
def resetData():
    # 默认数据
    staff01 = Staff(staffId = '012301', departId = '01', phoneNum = 13172290114, staffName = "达达利亚", sex = "男", age = 23, salary = 9000 ,job = "经理" ,entryTime="2023-09-15")
    staff02 = Staff(staffId = '012302', departId = '01', phoneNum = 17322297254, staffName = "万叶", sex = "男", age = 22, salary = 5100 ,job = "普通员工" ,entryTime="2023-09-15")
    staff03 = Staff(staffId = '012303', departId = '01', phoneNum = 19322904711, staffName = "香菱", sex = "女", age = 22, salary = 5300 ,job = "普通员工" ,entryTime="2023-09-15")
    staff04 = Staff(staffId = '022301', departId = '02', phoneNum = 13376629080, staffName = "班尼特", sex = "男", age = 21, salary = 7000 ,job = "经理" ,entryTime="2023-09-15")
    staff05 = Staff(staffId = '022302', departId = '02', phoneNum = 13376629080, staffName = "胡桃", sex = "女", age = 16, salary = 7000 ,job = "经理" ,entryTime="2023-09-15")
    staff06 = Staff(staffId = '032301', departId = '03', phoneNum = 13232234167, staffName = "行秋", sex = "男", age = 17, salary = 5000 ,job = "普通员工" ,entryTime="2023-09-15")
    staff07 = Staff(staffId = '042301', departId = '04', phoneNum = 15238199014, staffName = "钟离", sex = "男", age = 1000, salary = 7000 ,job = "经理" ,entryTime="2023-09-15")
    staff08 = Staff(staffId = '052301', departId = '05', phoneNum = 11371238904, staffName = "夜阑", sex = "女", age = 24, salary = 8000 ,job = "经理" ,entryTime="2023-09-15")
    staff09 = Staff(staffId = '052302', departId = '05', phoneNum = 11371238224, staffName = "纳西妲", sex = "女", age = 500, salary = 4000 ,job = "普通员工" ,entryTime="2023-09-15")
    staff10 = Staff(staffId = '052303', departId = '05', phoneNum = 12134444042, staffName = "莫娜", sex = "女", age = 23, salary = 3000 ,job = "普通员工" ,entryTime="2023-09-15")
    staff11 = Staff(staffId = '052304', departId = '05', phoneNum = 13472894789, staffName = "久岐忍", sex = "女", age = 22, salary = 4200 ,job = "普通员工" ,entryTime="2023-09-15")
    try:
        #清空原来表的数据
        Staff.clearData()
        #重新添加数据
        db.session.add_all([staff01, staff02, staff03, staff04, staff05, staff06, staff07, staff08, staff09, staff10, staff11])
        db.session.commit()
        # 返回体
        return jsonify({
            #返回状态码
            "code": 200,
            #返回信息描述
            "message": "成功",
            #返回值
            "data": "ok"
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


# 筛选所有员工数据
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
    # 薪资(区间)
    (startSalary-endSalary),
    # 加入公司的时间(区间)
    (startEntryTime-endEntryTime),
    # 离职公司的时间(区间)
    (startEntryTime-endEntryTime),
    # 搜索关键字
    searchValue:"",
    # 页码
    pageNo,
    # 一页显示多少条
    pageSize
}
"""
@staff.route('/staff/filterAll',methods=['POST'])
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
        startSalary = request.json.get('startSalary')
        endSalary = request.json.get('endSalary')
        startEntryTime = request.json.get('startEntryTime')
        endEntryTime = request.json.get('endEntryTime')
        searchValue = request.json.get('searchValue')
        pageNo = request.json.get('pageNo')
        pageSize = request.json.get('pageSize')
        # 查询出所有数据
        queryData = Staff.query.order_by(Staff.entryTime)
        # 查找权限
        userData = Admin_user.query.filter(Admin_user.staffId == userid).first()
        allStaffMsgView = userData.schema()["authority"].find("allStaffMsgView")
        # 有查看所有员工信息的权限
        if allStaffMsgView != -1:
            # 对查询出的数据筛选
            if departId != None  and departId != "":
                queryData = queryData.filter(Staff.departId == departId)
            if sex != None and sex != "":
                queryData = queryData.filter(Staff.sex == sex)
            if job != None and job != "":
                queryData = queryData.filter(Staff.job == job)
            if (startAge != None and endAge != None) and (endAge != 0):
                queryData = queryData.filter(Staff.age.between(startAge, endAge))
            if (startSalary != None and endSalary != None) and (endSalary != 0):
                queryData = queryData.filter(Staff.salary.between(startSalary, endSalary))
            if (startEntryTime != None) and (endEntryTime != None and endEntryTime != ""):
                queryData = queryData.filter(Staff.entryTime.between(startEntryTime, endEntryTime))
            if searchValue != None and searchValue != "":
                queryData = queryData.filter(Staff.staffName.like("%" + searchValue + "%"))
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
            userStaffData = Staff.query.filter(Staff.staffId == userid).first()
            if userStaffData == None:
                # 返回体
                return jsonify({
                    #返回状态码
                    "code": 400,
                    #返回信息描述
                    "message": "请确认你所在的部门是否存在",
                    #返回值
                    "data": {}
                })
            departId = userStaffData.schema()["departId"]
            queryData = queryData.filter(Staff.departId == departId).order_by(Staff.entryTime)
            if sex != None and sex != "":
                queryData = queryData.filter(Staff.sex == sex)
            if job != None and job != "":
                queryData = queryData.filter(Staff.job == job)
            if (startAge != None and endAge != None) and (endAge != 0):
                queryData = queryData.filter(Staff.age.between(startAge, endAge))
            if (startSalary != None and endSalary != None) and (endSalary != 0):
                queryData = queryData.filter(Staff.salary.between(startSalary, endSalary))
            if (startEntryTime != None) and (endEntryTime != None and endEntryTime != ""):
                queryData = queryData.filter(Staff.entryTime.between(startEntryTime, endEntryTime))
            if searchValue != None and searchValue != "":
                queryData = queryData.filter(Staff.staffName.like("%" + searchValue + "%"))
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
    

# 添加员工数据
# POST
# 接收的Post格式
"""
{
    # 部门
    departId,
    # 员工姓名
    staffName,
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
    
    # 请求操作用户id
    requestUserid
    # 操作内容审核id
    opid
}
"""
@staff.route('/staff/addStaff',methods=['POST'])
@jwt_required()
def addStaff():
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
        adminAddStaff = user.schema()["authority"].find("adminAddStaff")
        userAddStaff = user.schema()["authority"].find("userAddStaff")
        # 获取Post数据
        requestUserid = request.json.get('requestUserid')
        opid = request.json.get('opid')
        departId = request.json.get('departId')
        staffName = request.json.get('staffName')
        job = request.json.get('job')
        phoneNum = request.json.get('phoneNum')
        sex = request.json.get('sex')
        age = request.json.get('age')
        salary = request.json.get('salary')
        entryTime = request.json.get('entryTime')
        # 记录操作的内容
        addRecord = f"""
        <div>
            <p>数据信息：</p>
            <p>
                <span>部门名称：</span>
                <span>{Department.query.filter(Department.departId == departId).first().schema()["department_Name"]}</span>
            </p>
            <p>
                <span>员工姓名：</span>
                <span>{staffName}</span>
            </p>
            <p>
                <span>工种：</span>
                <span>{job}</span>
            </p>
            <p>
                <span>电话号码：</span>
                <span>{phoneNum}</span>
            </p>
            <p>
                <span>性别：</span>
                <span>{sex}</span>
            </p>
            <p>
                <span>年龄：</span>
                <span>{age}</span>
            </p>
            <p>
                <span>薪资：</span>
                <span>{salary}</span>
            </p>
            <p>
                <span>入职时间：</span>
                <span>{entryTime}</span>
            </p>
        </div>
        """
        # 获取当前部门人数并且按照部门人数、部门编号、进入公司年份生成员工ID
        staffCount = Staff.query.filter(Staff.departId == departId).count() + Resign.query.filter(Resign.departId == departId).count() + 1
        if staffCount < 10:
            staffCount = "0" + str(staffCount)
        staffId = departId + entryTime[2:4] + str(staffCount)
        # 对权限进行判断
        if adminAddStaff != -1:     
            # 记录操作内容
            if requestUserid == None:
                # 记录操作内容
                record = f"""
                <div class="add">
                <div>
                    <p>添加信息</p>
                    <p>{userid}用户添加了一位员工</p>
                </div>
                """ + addRecord+"</div>"
            else:
                # 其他用户的操作审核通过
                Admin_op_review.query.filter(Admin_op_review.id == opid).update({'status': "审核通过"})
                record = f'<div class="shortMsg">{requestUserid}用户的添加信息请求编号为{opid}已被{userid}用户审核并通过</div>'
            # 向员工表添加信息
            staff = Staff(staffId = staffId, departId = departId, phoneNum = phoneNum, staffName = staffName, sex = sex, age = age, salary = salary ,job = job ,entryTime = entryTime)
            # 向操作记录表添加信息
            msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
            db.session.add_all([staff,msg])
            db.session.commit()
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "添加成功",
                #返回值
                "data": {}
            })
        elif userAddStaff != -1:   
            # 操作的数据
            data = json.dumps({
                    "departId":departId,
                    "phoneNum":phoneNum,
                    "staffName":staffName,
                    "sex":sex,
                    "age":age,
                    "job":job,
                    "salary":salary,
                    "entryTime":entryTime
            })
            # 记录操作内容
            record = f"""
            <div class="add">
            <div>
                <p>添加信息</p>
                <p>{userid}用户需要添加一位员工</p>
            </div>
            """ + addRecord+"</div>"
            # 向操作内容审核表添加信息
            staff = Admin_op_review(staffId = userid, staffName = user.schema()["staffName"], data = data, description = "addRequest", datetime = getDate(), status = "待审核")
            # 向操作记录表添加信息
            msg = Admin_op_record(staffId = userid, content = record,  datetime = getDate())
            db.session.add_all([staff,msg])
            db.session.commit()
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "提交成功",
                #返回值
                "data": {}
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
    

# 修改员工数据
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
    # 请求操作用户id
    requestUserid
    # 操作内容审核id
    opid
}
"""
@staff.route('/staff/updateStaff',methods=['POST'])
@jwt_required()
def updateStaff():
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
        adminUpdateStaff = user[0].schema()["authority"].find("adminUpdateStaff")
        userUpdateStaff = user[0].schema()["authority"].find("userUpdateStaff")
        # 获取Post数据
        requestUserid = request.json.get('requestUserid')
        opid = request.json.get('opid')
        staffId = request.json.get('staffId')
        departId = request.json.get('departId')
        staffName = request.json.get('staffName')
        job = request.json.get('job')
        phoneNum = request.json.get('phoneNum')
        sex = request.json.get('sex')
        age = request.json.get('age')
        salary = request.json.get('salary')
        entryTime = request.json.get('entryTime')
        # 获取原来的信息
        oldData = Staff.query.filter(Staff.staffId == staffId).first()
        # 记录操作前的内容
        oldDataRecord = f"""
        <div>
            <p>修改前的数据：</p>
            <p>
                <span>员工号：</span>
                <span>{oldData.schema()['staffId']}</span>
            </p>
            <p>
                <span>部门名称：</span>
                <span>{Department.query.filter(Department.departId == oldData.schema()['departId']).first().schema()["department_Name"]}</span>
            </p>
            <p>
                <span>员工姓名：</span>
                <span>{oldData.schema()['staffName']}</span>
            </p>
            <p>
                <span>职位：</span>
                <span>{oldData.schema()['job']}</span>
            </p>
            <p>
                <span>电话号码：</span>
                <span>{oldData.schema()['phoneNum']}</span>
            </p>
            <p>
                <span>性别：</span>
                <span>{oldData.schema()['sex']}</span>
            </p>
            <p>
                <span>年龄：</span>
                <span>{oldData.schema()['age']}</span>
            </p>
            <p>
                <span>薪资：</span>
                <span>{oldData.schema()['salary']}</span>
            </p>
            <p>
                <span>入职时间：</span>
                <span>{oldData.schema()['entryTime']}</span>
            </p>
        </div>
        """
        # 记录操作后的内容
        newDataRecord = f"""
        <div>
            <p>修改后的数据：</p>
            <p>
                <span>员工号：</span>
                <span>{staffId}</span>
            </p>
            <p>
                <span>部门名称：</span>
                <span>{Department.query.filter(Department.departId == departId).first().schema()["department_Name"]}</span>
            </p>
            <p>
                <span>员工姓名：</span>
                <span>{staffName}</span>
            </p>
            <p>
                <span>职位：</span>
                <span>{job}</span>
            </p>
            <p>
                <span>电话号码：</span>
                <span>{phoneNum}</span>
            </p>
            <p>
                <span>性别：</span>
                <span>{sex}</span>
            </p>
            <p>
                <span>年龄：</span>
                <span>{age}</span>
            </p>
            <p>
                <span>薪资：</span>
                <span>{salary}</span>
            </p>
            <p>
                <span>入职时间：</span>
                <span>{entryTime}</span>
            </p>
        </div>
        """
        # 对权限进行判断
        if adminUpdateStaff != -1:     
            # 管理员操作
            # 记录操作内容
            if requestUserid == None:
                #管理员自己的操作
                # 记录操作内容
                record = f"""
                <div class='update'>
                    <div>
                        <p>修改信息请求</p>
                        <p>{userid}用户修改员工号为{staffId}员工的信息</p>
                    </div>
                """+ oldDataRecord + newDataRecord + "</div>"
            else:
                # 审核修改
                # 其他用户的操作审核通过
                Admin_op_review.query.filter(Admin_op_review.id == opid).update({'status': "审核通过"})
                record = f'<div class="shortMsg">{requestUserid}用户的修改信息请求编号为{opid}已被{userid}用户审核并通过</div>'
            # 向员工表更新信息
            Staff.query.filter(Staff.staffId == staffId).update({
                        'departId': departId,
                        'staffName':staffName,
                        'job':job,
                        "phoneNum":phoneNum,
                        "sex":sex,
                        "age":age,
                        "salary":salary,
                        "entryTime":entryTime,
            })
            # 向操作记录表添加信息
            msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
            db.session.add_all([msg])
            db.session.commit()
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "修改成功",
                #返回值
                "data": {}
            })
        elif userUpdateStaff != -1: 
            # 用户操作  
            # 记录操作的数据
            data = json.dumps({
                "oldData":{
                    "staffId":oldData.schema()['staffId'],
                    "departId":oldData.schema()['departId'],
                    "phoneNum":oldData.schema()['phoneNum'],
                    "job":oldData.schema()['job'],
                    "staffName":oldData.schema()['staffName'],
                    "sex":oldData.schema()['sex'],
                    "age":oldData.schema()['age'],
                    "salary":oldData.schema()['salary'],
                    "entryTime":str(oldData.schema()['entryTime']) 
                },
                "newData":{
                    "staffId":staffId,
                    "departId":departId,
                    "phoneNum":phoneNum,
                    "job":job,
                    "staffName":staffName,
                    "sex":sex,
                    "age":age,
                    "salary":salary,
                    "entryTime":entryTime
                }
            })
            # 记录操作内容
            record = f"""
            <div class='update'>
                <div>
                    <p>修改信息请求</p>
                    <p>{userid}用户想要修改员工号为{staffId}员工的信息</p>
                </div>
            """+ oldDataRecord + newDataRecord + "</div>"
            # 向操作内容审核表添加信息
            opReview = Admin_op_review(staffId = userid, staffName = user[0].schema()["staffName"], data = data, description = "updateRequest", datetime = getDate(), status = "待审核")
            # 向操作记录表添加信息
            opRecord = Admin_op_record(staffId = userid, content = record,  datetime = getDate())
            db.session.add_all([opReview,opRecord])
            db.session.commit()
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "提交修改请求成功",
                #返回值
                "data": {}
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

# 所有员工职位类型
# GET
@staff.route('/staff/jobType',methods=['GET'])
@jwt_required()
def jobType():
    dataList = ["普通员工","经理","实习生"]
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
        # 返回体
        return jsonify({
            #返回状态码
            "code": 200,
            #返回信息描述
            "message": "成功",
            #返回值
            "data": dataList
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

# 搜索员工
# GET
# 接收的GET格式
"""
    # 状态
    keyValue
"""
@staff.route('/staff/search',methods=['GET'])
@jwt_required()
def search():
    dataList = []
    try:
        userid = get_jwt_identity()
        # 操作内容请求状态
        keyValue = request.args.get("keyValue")
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
        addAdminUser = userData.schema()["authority"].find("addAdminUser")
        # 有查看所有员工信息的权限
        if addAdminUser != -1:
            # 根据输入内容搜索
            if keyValue != None and keyValue != "":
                queryData = Staff.query.filter(Staff.staffName.like("%" + keyValue + "%")).all()
            else:
                queryData = Staff.query.filter_by()
            # 添加到dataList
            for item in queryData:
                dataList.append({
                    "staffId":item.schema()["staffId"],
                    "staffName":item.schema()["staffName"],
                })
            # 返回体
            return jsonify({
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "成功",
                #返回值
                "data": dataList
            })
        else:
            # 返回体
            return jsonify({
                #返回状态码
                "code": 403,
                #返回信息描述
                "message": "你没有权限",
                #返回值
                "data": []
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