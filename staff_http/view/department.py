from flask import Blueprint
from extension import db
from models import Department,Staff
from flask import jsonify

department = Blueprint('department',__name__)

# 重置数据
@department.route('/department/resetData',methods=['GET'])
def resetData():
    # 默认数据
    department1 = Department(departId = '01', department_Name = '管理层', manager_staffId = "0102301")
    department2 = Department(departId = '02', department_Name = '开发部', manager_staffId = "0202301")
    department3 = Department(departId = '03', department_Name = '测试部', manager_staffId = "0302301")
    department4 = Department(departId = '04', department_Name = '人力资源', manager_staffId = "0402301")
    department5 = Department(departId = '05', department_Name = '运维部', manager_staffId = "0502301")

    try:
        #清空原来表的数据
        Department.clearData()
        #重新添加数据
        db.session.add_all([department1, department2, department3, department4, department5])
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
@department.route('/department/queryAll',methods=['GET'])
def queryAll():
    dataList = []
    try:
        # 查询部门表所有数据
        queryData = Department.query.filter_by()
        # 添加到dataList
        for item in queryData:
            dataList.append({
                "departId":item.schema()["departId"],
                "department_Name":item.schema()["department_Name"],
                "manager_staffName":Staff.query.filter(Staff.staffId == item.schema()["manager_staffId"]).first().schema()["staffName"],
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
     
        