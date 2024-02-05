from flask import Blueprint
from extension import db
from models import Admin_user
from flask import jsonify
from flask import request
from sqlalchemy import and_
from flask_jwt_extended import create_access_token, get_jwt_identity, jwt_required
from setting import redis_client,scheduler,app
import time

admin_user = Blueprint('admin_user',__name__)

def timerLogin(i):
    with app.app_context():
        # 修改登录用户的状态
        Admin_user.query.filter(Admin_user.staffId == i).update({'status': "下线"})
        print(123)
        db.session.commit()
        scheduler.remove_job("timerLogin")


# 重置数据d
@admin_user.route('/admin_user/resetData',methods=['GET'])
def resetData():
    # 默认数据
    user1 = Admin_user(staffId = "admin",departId = "01", staffName = "admin",password = "admin",status = "在线", authority = "home,staff,staffMsg,checkingIn,settingDimission,allStaffMsgView,adminAddStaff,adminUpdateStaff,updateCheckingIn,allStaffCheckingInView")
    try:
        #清空原来表的数据
        Admin_user.clearData()
        #重新添加数据
        db.session.add_all([
            user1,
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

# 登录
# POST
# 接收的Post格式
# {
#     # 员工ID
#     staffId,
#     # 密码
#     password
# }
@admin_user.route('/admin_user/login',methods=['POST'])
def login():
    # try:
        # 获取post数据
        staffId = request.json.get('staffId')
        password = request.json.get('password')
        # 查找是否有该用户
        adminUser = Admin_user.query.filter(and_(Admin_user.staffId == staffId,Admin_user.password == password)).first(),
        if adminUser[0] == None:
            # 用户不存在
            return jsonify({           
                #返回状态码
                "code": 401,
                #返回信息描述
                "message": "用户名或密码错误",
                #返回值
                "data": {}
            })
        else:
            # 用户存在
            # 修改登录用户的状态
            Admin_user.query.filter(Admin_user.staffId == adminUser[0].schema()["staffId"]).update({'status': "在线"})
            db.session.commit()
            # 生成token
            token = create_access_token( identity = adminUser[0].schema()["staffId"] )
            # 添加token到redis
            redis_client.set(adminUser[0].schema()["staffId"], token)
            if(scheduler.get_job('timerLogin') == None):
                # 添加定时任务
                scheduler.add_job(func=timerLogin, id="timerLogin", args=(adminUser[0].schema()["staffId"],), trigger='interval', seconds= 900 )
            else:
                # 去掉之前的定时任务
                scheduler.remove_job("timerLogin")
                # 重新添加定时任务
                scheduler.add_job(func=timerLogin, id="timerLogin", args=(adminUser[0].schema()["staffId"],), trigger='interval', seconds= 900 )
            # 设置过期时间
            redis_client.expireat(adminUser[0].schema()["staffId"], int (time.time()) + 900)
            # 返回体
            return jsonify({           
                #返回状态码
                "code": 200,
                #返回信息描述
                "message": "登录成功",
                #返回值
                "data": {
                    "staffName":adminUser[0].schema()["staffName"],
                    "staffId":adminUser[0].schema()["staffId"],
                    "departId":adminUser[0].schema()["departId"],
                    "token":token,
                    "authority":adminUser[0].schema()["authority"],
                }
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


# 退出登录
# GET
@admin_user.route('/admin_user/logout',methods=['GET'])
@jwt_required()
def logout():
    # try:
        # 身份验证
        userid = get_jwt_identity()
        # 获取header的token
        if request.headers['Authorization']:
            headerToken = request.headers['Authorization'].split('Bearer ')[1]
        else:
            headerToken = ""
        # 获取redis的token
        token = redis_client.get(userid)
        # 判断token是否存在并且和头部的token是否一致
        if not token or token.decode() != headerToken:
            # 返回体
            return jsonify({
            #返回状态码
                "code": 422,
                #返回信息描述
                "message": "身份已过期，请重新登录",
                #返回值
                "data": {}
            }) 
        # 删除redis的token
        redis_client.delete(userid)
        # 修改登录用户的状态
        Admin_user.query.filter(Admin_user.staffId == userid).update({'status': "下线"})
        db.session.commit()
        if(scheduler.get_job('timerLogin') != None):
            # 取消定时任务
            scheduler.remove_job("timerLogin")
        return jsonify({           
            #返回状态码
            "code": 200,
            #返回信息描述
            "message": "退出登录成功",
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


#查询所有用户
# GET
@admin_user.route('/admin_user/queryAll',methods=['GET'])
@jwt_required()
def queryAll():
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
        # 查询用户表所有数据
        queryData = Admin_user.query.filter_by()
        # 添加到dataList
        for item in queryData:
            dataList.append({
                "staffId":item.schema()["staffId"],
                "staffName":item.schema()["staffName"],
                "password":item.schema()["password"],
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
