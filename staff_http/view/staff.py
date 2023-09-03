from flask import Blueprint
from extension import db
from models import Staff,Department
from flask import jsonify

staff = Blueprint('staff',__name__)

# 重置数据
@staff.route('/staff/resetData',methods=['GET'])
def resetData():
    # 默认数据
    staff01 = Staff(staffId = '0102301', departId = '01', phoneNum = 13172290114, staffName = "达达利亚", sex = "男", age = 23, salary = 9000 ,job = "经理" ,entryTime="2023-09-15")
    staff02 = Staff(staffId = '0102302', departId = '01', phoneNum = 17322297254, staffName = "万叶", sex = "男", age = 22, salary = 5100 ,job = "普通员工" ,entryTime="2023-09-15")
    staff03 = Staff(staffId = '0102303', departId = '01', phoneNum = 19322904711, staffName = "香菱", sex = "女", age = 22, salary = 5300 ,job = "普通员工" ,entryTime="2023-09-15")
    staff04 = Staff(staffId = '0202301', departId = '02', phoneNum = 13376629080, staffName = "班尼特", sex = "男", age = 21, salary = 7000 ,job = "经理" ,entryTime="2023-09-15")
    staff05 = Staff(staffId = '0202302', departId = '02', phoneNum = 13376629080, staffName = "胡桃", sex = "女", age = 16, salary = 7000 ,job = "经理" ,entryTime="2023-09-15")
    staff06 = Staff(staffId = '0302301', departId = '03', phoneNum = 13232234167, staffName = "行秋", sex = "男", age = 17, salary = 5000 ,job = "普通员工" ,entryTime="2023-09-15")
    staff07 = Staff(staffId = '0402301', departId = '04', phoneNum = 15238199014, staffName = "钟离", sex = "男", age = 1000, salary = 7000 ,job = "经理" ,entryTime="2023-09-15")
    staff08 = Staff(staffId = '0502301', departId = '05', phoneNum = 11371238904, staffName = "夜阑", sex = "女", age = 24, salary = 8000 ,job = "经理" ,entryTime="2023-09-15")
    staff09 = Staff(staffId = '0502302', departId = '05', phoneNum = 11371238224, staffName = "纳西妲", sex = "女", age = 500, salary = 4000 ,job = "普通员工" ,entryTime="2023-09-15")
    staff10 = Staff(staffId = '0502303', departId = '05', phoneNum = 12134444042, staffName = "莫娜", sex = "女", age = 23, salary = 3000 ,job = "普通员工" ,entryTime="2023-09-15")
    staff11 = Staff(staffId = '0502304', departId = '05', phoneNum = 13472894789, staffName = "久岐忍", sex = "女", age = 22, salary = 4200 ,job = "普通员工" ,entryTime="2023-09-15")
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
    

# 查询所有数据
@staff.route('/staff/queryAll',methods=['GET'])
def queryAll():
    dataList = []
    try:
        # 查询员工表所有数据
        queryData = Staff.query.filter_by()
        # 添加到dataList
        for item in queryData:
            dataList.append({
                "staffId":item.schema()["staffId"],
                "departName":Department.query.filter(Department.departId == item.schema()["departId"]).first().schema()["department_Name"],
                "phoneNum":item.schema()["phoneNum"],
                "staffName":item.schema()["staffName"],
                "sex":item.schema()["sex"],
                "age":item.schema()["age"],
                "salary":item.schema()["salary"],
                "job":item.schema()["job"],
                "entryTime":item.schema()["entryTime"],
                
            })
        # # 返回体
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