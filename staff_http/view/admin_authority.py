from flask import Blueprint
from extension import db
from flask import jsonify
from flask import Blueprint
from extension import db
from models import Admin_user,Admin_authority
from flask import jsonify
from flask import request
from sqlalchemy import and_
from setting import redis_client
from flask_jwt_extended import  get_jwt_identity, jwt_required
admin_authority = Blueprint('admin_authority',__name__)

# 重置数据
@admin_authority.route('/admin_authority/resetData',methods=['GET'])
def resetData():
    # 默认数据
    admin_authority1 = Admin_authority(one_level_name = "home", right_name = "home", description = "首页")
    admin_authority2 = Admin_authority(one_level_name = "staff", right_name = "staff", description = "员工管理")
    admin_authority3 = Admin_authority(one_level_name = "staff", two_level_name= "staffMsg", right_name = "staffMsg", description = "员工信息")
    admin_authority4 = Admin_authority(one_level_name = "staff", two_level_name= "checkingIn", right_name = "checkingIn", description = "考勤管理")
    admin_authority5 = Admin_authority(one_level_name = "staff", two_level_name= "staffMsg", three_level_name = "userAddStaff", right_name = "userAddStaff", description = "添加员工(需审核)")
    admin_authority6 = Admin_authority(one_level_name = "staff", two_level_name= "staffMsg", three_level_name = "userUpdateStaff", right_name = "userUpdateStaff", description = "修改员工(需审核)")
    admin_authority7 = Admin_authority(one_level_name = "staff", two_level_name= "staffMsg", three_level_name = "settingDimission", right_name = "settingDimission", description = "设置为离职")
    admin_authority8 = Admin_authority(one_level_name = "staff", two_level_name= "staffMsg", three_level_name = "allStaffMsgView", right_name = "allStaffMsgView", description = "所有员工信息")
    admin_authority9 = Admin_authority(one_level_name = "staff", two_level_name= "staffMsg", three_level_name = "adminAddStaff", right_name = "adminAddStaff", description = "添加员工(无需审核)")
    admin_authority10 = Admin_authority(one_level_name = "staff", two_level_name= "staffMsg", three_level_name = "adminUpdateStaff", right_name = "adminUpdateStaff", description = "修改员工(无需审核)")
    admin_authority11 = Admin_authority(one_level_name = "staff", two_level_name= "checkingIn", three_level_name = "updateCheckingIn", right_name = "updateCheckingIn", description = "修改员工考勤")
    admin_authority12 = Admin_authority(one_level_name = "staff", two_level_name= "checkingIn", three_level_name = "allStaffCheckingInView", right_name = "allStaffCheckingInView", description = "所有员工考勤")
    
    try:
        #清空原来表的数据
        Admin_authority.clearData()
        #重新添加数据
        db.session.add_all([
            admin_authority1,
            admin_authority2,
            admin_authority3,
            admin_authority4,
            admin_authority5,
            admin_authority6,
            admin_authority7,
            admin_authority8,
            admin_authority9,
            admin_authority10,
            admin_authority11,
            admin_authority12
        ])
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
    


# 查看权限表
# GET
@admin_authority.route('/admin_authority/allData',methods=['GET'])
@jwt_required()
def allData():
    dataList = []
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
        # 查找权限
        userData = Admin_user.query.filter(Admin_user.staffId == userid).first()
        allotAuthority = userData.schema()["authority"].find("allotAuthority")
        if allotAuthority != -1:
            # 查询用户表所有数据
            queryData = Admin_authority.query.filter_by()
            # 添加到dataList
            for item in queryData:
                dataList.append({
                    "id":item.schema()["id"],
                    "one_level_name":item.schema()["one_level_name"],
                    "two_level_name":item.schema()["two_level_name"],
                    "three_level_name":item.schema()["three_level_name"],
                    "right_name":item.schema()["right_name"],
                    "description":item.schema()["description"],
                })
            # 返回体
            return jsonify({
            #返回状态码
                "code": 200,
                #返回信息描述
                "message": "成功",
                #返回值
                "data": {
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