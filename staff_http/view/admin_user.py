from flask import Blueprint
from extension import db
from models import Admin_user,Admin_op_record,Staff,Admin_authority,Department
from flask import jsonify
from flask import request
from sqlalchemy import and_
from flask_jwt_extended import create_access_token, get_jwt_identity, jwt_required
from setting import redis_client,scheduler,app
import time
from until import getDate

admin_user = Blueprint('admin_user',__name__)

def timerLogin(i):
    with app.app_context():
        # 修改登录用户的状态
        Admin_user.query.filter(Admin_user.staffId == i).update({'status': "下线"})
        db.session.commit()
        scheduler.remove_job("timerLogin")

# 登录
# POST
# 接收的Post格式
"""
{
    # 员工ID
    staffId,
    # 密码
    password
}
"""
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
                "code": 402,
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
            # 获取redis的token
            resetToken = redis_client.get(staffId)
            if resetToken:
                    # 删除redis的token
                redis_client.delete(staffId)
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
            print(123)
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
    try:
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


#查询所有用户
# GET
"""
    # 部门
    departId,
    # 状态
    status,
    # 页码
    pageNo
"""
@admin_user.route('/admin_user/queryAll',methods=['GET'])
@jwt_required()
def queryAll():
    dataList = []
    try:
        # 页码
        pageNo = request.args.get("pageNo")
        # 页码
        status = request.args.get("status")
        # 页码
        departId = request.args.get("departId")
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
        user = userData.schema()["authority"].find("user")
        if user != -1:
            # 查询用户表所有数据
            queryData = Admin_user.query.filter_by()
            # 状态查找
            if status != None and status != "":
                queryData = queryData.filter(Admin_user.status == status)
            # 关键字查找
            if departId != None and departId != "":
                queryData = queryData.filter(Admin_user.departId == departId)
             # 分页
            pn = queryData.paginate(page=int(pageNo), per_page=15, error_out=False)
            # 添加到dataList
            for item in pn:
                dataList.append({
                    "staffId":item.schema()["staffId"],
                    "staffName":item.schema()["staffName"],
                    "departId":item.schema()["departId"],
                    "departName":Department.query.filter(Department.departId == item.schema()["departId"]).first().schema()["department_Name"],
                    "password":"none",
                    "status":item.schema()["status"],
                    "authority":item.schema()["authority"],
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


# 查看某位用户的密码
# POST
# 接收的Post格式
"""
{
    # 员工ID
    staffId,
    # 想要查看密码的人的密码
    requireUserPassword
}
"""
@admin_user.route('/admin_user/showPassWord',methods=['POST'])
@jwt_required()
def showPassWord():
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
        staffId = request.json.get('staffId')
        requireUserPassword = request.json.get('requireUserPassword')
        # 查找是否有该用户
        adminUser = Admin_user.query.filter(and_(Admin_user.staffId == userid,Admin_user.password == requireUserPassword)).first(),
        # 密码错误
        if adminUser[0] == None:
            # 用户不存在
            return jsonify({           
                #返回状态码
                "code": 402,
                #返回信息描述
                "message": "密码错误",
                #返回值
                "data": {}
            })
        else:
            # 查找权限
            showUserPassWord = adminUser[0].schema()["authority"].find("showUserPassWord")
            if showUserPassWord != -1:
                # 查找密码
                queryData = Admin_user.query.filter(Admin_user.staffId == staffId).first()
                # 记下操作记录
                record = f'<div class="shortMsg">{userid}查看了{staffId}的密码</div>'
                # 向操作记录表添加信息
                msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
                db.session.add_all([msg])
                db.session.commit()
                # 返回体
                return jsonify({           
                    #返回状态码
                    "code": 200,
                    #返回信息描述
                    "message": "获取成功",
                    #返回值
                    "data": {
                        "staffId":queryData.schema()["staffId"],
                        "password":queryData.schema()["password"]
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



# 修改某位用户的密码
# POST
# 接收的Post格式
"""
{
    # 员工ID
    staffId,
    # 修改后的密码
    password
    # 想要修改密码的人的密码
    requireUserPassword
}
"""
@admin_user.route('/admin_user/updatePassWord',methods=['POST'])
@jwt_required()
def updatePassWord():
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
        staffId = request.json.get('staffId')
        requireUserPassword = request.json.get('requireUserPassword')
        password = request.json.get('password')
        # 查找是否有该用户
        adminUser = Admin_user.query.filter(and_(Admin_user.staffId == userid,Admin_user.password == requireUserPassword)).first(),
        # 密码错误
        if adminUser[0] == None:
            # 用户不存在
            return jsonify({           
                #返回状态码
                "code": 402,
                #返回信息描述
                "message": "密码错误",
                #返回值
                "data": {}
            })
        else:
            # 查找权限
            updateUserPassWord = adminUser[0].schema()["authority"].find("updateUserPassWord")
            if updateUserPassWord != -1:
                # 记下操作记录
                record = f'<div class="shortMsg">{userid}修改了{staffId}的密码</div>'
                # 修改密码
                Admin_user.query.filter(Admin_user.staffId == staffId).update({'password': password})
                # 向操作记录表添加信息
                msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
                # 获取redis的token
                resetToken = redis_client.get(staffId)
                if resetToken:
                     # 删除redis的token
                    redis_client.delete(staffId)
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
    


# 删除某位用户
# POST
# 接收的Post格式
"""
{
    # 员工ID
    staffId,
    # 想要删除用户的人的密码
    requireUserPassword
}
"""
@admin_user.route('/admin_user/deleteUser',methods=['POST'])
@jwt_required()
def deleteUser():
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
        staffId = request.json.get('staffId')
        requireUserPassword = request.json.get('requireUserPassword')
        # 查找是否有该用户
        adminUser = Admin_user.query.filter(and_(Admin_user.staffId == userid,Admin_user.password == requireUserPassword)).first(),
        # 密码错误
        if adminUser[0] == None:
            # 用户不存在
            return jsonify({           
                #返回状态码
                "code": 402,
                #返回信息描述
                "message": "密码错误",
                #返回值
                "data": {}
            })
        else:
            # 查找权限
            deleteUser = adminUser[0].schema()["authority"].find("deleteUser")
            if deleteUser != -1:
                beDelete = Admin_user.query.filter(Admin_user.staffId == staffId).first()
                beDeleteUserAuthority = beDelete.schema()["authority"].find("allotAuthority")
                # 无法删除最后一个拥有分配权限的人
                if  beDeleteUserAuthority != -1:
                    islast = Admin_user.query.filter(Admin_user.authority.like("%allotAuthority%")).all()
                    if len(islast) <= 1 and islast[0].schema()["staffId"] == staffId:
                        return jsonify({           
                            #返回状态码
                            "code": 400,
                            #返回信息描述
                            "message": "无法删除最后一个拥有分配权限的人",
                            #返回值
                            "data": {}
                        })
                # 记下操作记录
                record = f'<div class="shortMsg">{userid}删除了{staffId}用户</div>'
                # 删除用户
                Admin_user.query.filter(Admin_user.staffId == staffId).delete()
                # 向操作记录表添加信息
                msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
                # 获取redis的token
                resetToken = redis_client.get(staffId)
                if resetToken:
                     # 删除redis的token
                    redis_client.delete(staffId)
                db.session.add_all([msg])
                db.session.commit()
                # 返回体
                return jsonify({           
                    #返回状态码
                    "code": 200,
                    #返回信息描述
                    "message": "删除成功",
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
    


# 添加用户某位用户
# POST
# 接收的Post格式
"""
{
    # 员工ID
    staffId,
    # 员工密码
    password,
    # 执行操作的人的密码
    requireUserPassword
}
"""
@admin_user.route('/admin_user/addAdmin',methods=['POST'])
@jwt_required()
def addAdmin():
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
        staffId = request.json.get('staffId')
        password = request.json.get('password')
        requireUserPassword = request.json.get('requireUserPassword')
        # 查找是否有该用户
        adminUser = Admin_user.query.filter(and_(Admin_user.staffId == userid,Admin_user.password == requireUserPassword)).first(),
        # 密码错误
        if adminUser[0] == None:
            # 用户不存在
            return jsonify({           
                #返回状态码
                "code": 402,
                #返回信息描述
                "message": "密码错误",
                #返回值
                "data": {}
            })
        else:
            # 查找权限
            addAdminUser = adminUser[0].schema()["authority"].find("addAdminUser")
            if addAdminUser != -1:
                # 记下操作记录
                record = f'<div class="shortMsg">{userid}添加了{staffId}用户</div>'
                # 查找是否有该员工
                staff = Staff.query.filter(Staff.staffId == staffId).first(),
                # 判断
                if staff[0] == None:
                    # 用户不存在
                    return jsonify({           
                        #返回状态码
                        "code": 400,
                        #返回信息描述
                        "message": "请添加本公司的员工",
                        #返回值
                        "data": {}
                    })
                # 查找是否有该用户
                hasAdminUser = Admin_user.query.filter(Admin_user.staffId == staffId).first(),
                # 判断
                if hasAdminUser[0] != None:
                    # 用户不存在
                    return jsonify({           
                        #返回状态码
                        "code": 400,
                        #返回信息描述
                        "message": "已有该用户，不可再次添加",
                        #返回值
                        "data": {}
                    })
                # 添加用户
                user = Admin_user(staffId = staff[0].schema()["staffId"],departId = staff[0].schema()["departId"], staffName = staff[0].schema()["staffName"],password = password,status = "下线", authority = "home")
                # 向操作记录表添加信息
                msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
                db.session.add_all([msg,user])
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
    


# 分配权限
# POST
# 接收的Post格式
"""
{
    # 员工ID
    staffId,
    # 权限表
    authorityString,
    # 想要分配权限用户的人的密码
    requireUserPassword
}
"""
@admin_user.route('/admin_user/allotAuth',methods=['POST'])
@jwt_required()
def allotAuth():
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
        staffId = request.json.get('staffId')
        authorityString = request.json.get('authorityString')
        requireUserPassword = request.json.get('requireUserPassword')
        # 查找是否有该用户
        adminUser = Admin_user.query.filter(and_(Admin_user.staffId == userid,Admin_user.password == requireUserPassword)).first()
        # 密码错误
        if adminUser == None:
            # 用户不存在
            return jsonify({           
                #返回状态码
                "code": 402,
                #返回信息描述
                "message": "密码错误",
                #返回值
                "data": {}
            })
        else:
            # 查找权限
            allotAuthority = adminUser.schema()["authority"].find("allotAuthority")
            if allotAuthority != -1:
                # 查找分配的权限中是否拥有分配权限的能力
                isHasAuth = authorityString.find("allotAuthority")
                # 如果没有分配给用户分配权限的能力
                if isHasAuth == -1:
                    # 查找是否当前有分配权限的人
                    islast = Admin_user.query.filter(Admin_user.authority.like("%allotAuthority%")).all()
                    if len(islast) <= 1 and islast[0].schema()["staffId"] == staffId:
                        return jsonify({           
                            #返回状态码
                            "code": 400,
                            #返回信息描述
                            "message": "必须要有一个拥有分配权限的人",
                            #返回值
                            "data": {}
                        })
                # 遍历分配过来的权限表
                string = ""
                authorityList = authorityString.split(",")
                for i in authorityList:
                    if i != '':
                        description = Admin_authority.query.filter(Admin_authority.right_name == i).first()
                        string += f"""<span>{description.schema()["description"]}</span>"""
                # 记下操作记录
                record = f"""
                    <div class="authority">
                        <p>{userid}分配权限给了{staffId}</p>
                        
                        <div>
                """ + string + "</div></div>"
                # 修改权限
                Admin_user.query.filter(Admin_user.staffId == staffId).update({'authority': authorityString})
                # 向操作记录表添加信息
                msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
                resetToken = redis_client.get(staffId)
                if resetToken:
                     # 删除redis的token
                    redis_client.delete(staffId)
                db.session.add_all([msg])
                db.session.commit()
                # 返回体
                return jsonify({           
                    #返回状态码
                    "code": 200,
                    #返回信息描述
                    "message": "分配成功",
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
    
















