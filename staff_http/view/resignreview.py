from flask import Blueprint
from extension import db
from models import Staff,Admin_op_record,Admin_user,Resign,Department,Resignreview
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from until import getDate
from setting import redis_client


resignreview = Blueprint('resignreview',__name__)

# 筛选出所有数据
# GET
# 接收的GET格式
"""
    # 状态
    status(待审核、审核通过、审核驳回)
    # 页码
    pageNo
"""
@resignreview.route('/resignreview/filterAll',methods=['GET'])
@jwt_required()
def queryAll():
    dataList = []
    try:
        # 身份验证
        userid = get_jwt_identity()
        # 操作内容请求状态
        status = request.args.get("status")
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
        dimissionAudit = userData.schema()["authority"].find("dimissionAudit")
        if dimissionAudit != -1:
            # 查询操作内容审核表所有数据
            if status == "全部" or status == "" or status == None:
                queryData = Resignreview.query.filter_by()
            else:
                queryData = Resignreview.query.filter(Resignreview.status == status)
            # 排序
            queryData = queryData.order_by(-Resignreview.dateTime)
            # 分页
            pn = queryData.paginate(page=int(pageNo), per_page=15, error_out=False)
            # 添加到dataList
            for item in pn:
                dataList.append({
                    "id":item.schema()["id"],
                    "content":item.schema()["content"],
                    "staffId":item.schema()["staffId"],
                    "staffName":item.schema()["staffName"],
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
@resignreview.route('/resignreview/updateStatus',methods=['POST'])
@jwt_required()
def updateStatus():
    try:
        userid = get_jwt_identity()
        opid = request.json.get("opid")
        staffId = request.json.get('staffId')
        status = request.json.get('status')
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
        updateResignReviewStatus = userData.schema()["authority"].find("updateResignReviewStatus")
        if updateResignReviewStatus != -1:
            if status == '审核驳回':
                # 审核修改
                # 其他用户的操作审核通过
                Resignreview.query.filter(Resignreview.id == opid).update({'status': status})
                # 记下操作记录
                record = f'<div class="shortMsg">{staffId}员工的离职申请已被{userid}用户驳回</div>'
                # 向操作记录表添加信息
                msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
                db.session.add_all([msg])
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
            elif status == '审核通过':
                # 查询要离职的员工
                staff = Staff.query.filter(Staff.staffId == staffId).first()
                if staff == None:
                    # 返回体
                    return jsonify({
                        #返回状态码
                        "code": 401,
                        #返回信息描述
                        "message": '未找到该名员工',
                        #返回值
                        "data": {}
                    })
                # 添加到离职员工表
                resignStaff = Resign(staffId = staffId, departId = staff.schema()["departId"], phoneNum = staff.schema()["phoneNum"], staffName = staff.schema()["staffName"], sex = staff.schema()["sex"], age = staff.schema()["age"], salary = staff.schema()["salary"] ,job = staff.schema()["job"] ,entryTime = staff.schema()["entryTime"] ,resignTime = getDate())
                # 审核修改
                # 其他用户的操作审核通过
                Resignreview.query.filter(Resignreview.id == opid).update({'status': status})
                # 记下操作记录
                record = f'<div class="shortMsg">{userid}用户通过了{staffId}员工的离职申请</div>'
                # 向操作记录表添加信息
                msg = Admin_op_record(staffId = userid, content = record, datetime = getDate())
                db.session.add_all([msg,resignStaff])
                # 从员工数据表删除
                Staff.query.filter(Staff.staffId == staffId).delete()
                db.session.commit()
                # 返回体
                return jsonify({
                    #返回状态码
                    "code": 200,
                    #返回信息描述
                    "message": status + ',已设为离职员工',
                    #返回值
                    "data": {}
                })
            else:
                return jsonify({
                    #返回状态码
                    "code": 401,
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