from datetime import date, datetime, time, timedelta
from flask import Blueprint
from extension import db
from models import Workattendance,Staff,Admin_user
from flask import jsonify
from flask import request
from flask_jwt_extended import jwt_required,get_jwt_identity
from sqlalchemy import and_
from until import getDate,random_time,setStatus
from setting import redis_client
import json

workattendance = Blueprint('workattendance',__name__)

# 模拟打卡
@workattendance.route('/workattendance/check',methods=['GET'])
def workattendanceCheck():
    dataList = []
    # 查询出所有数据
    queryData = Staff.query.order_by(Staff.entryTime)
    date = "2024-04-29"
    # 添加到dataList
    for item in queryData:
        startTime = random_time("上")
        endTime = random_time("下")
        dataList.append({
            "staffId":item.schema()["staffId"],
            "staffName":item.schema()["staffName"],
            "departId":item.schema()["departId"],
            "date":date,
            "startTime":startTime,
            "endTime":endTime,
            "status":setStatus(startTime,endTime),
        })
    commit = []
    for item in dataList:
        qingjia = Workattendance.query.filter(and_(Workattendance.staffId == item["staffId"],Workattendance.date == date)).first()
        if(qingjia == None):
            msg = Workattendance(staffId = item["staffId"], staffName = item["staffName"], date = item["date"], startTime = item["startTime"], endTime = item["endTime"], status = item["status"], departId = item["departId"])
            commit.append(msg)
    db.session.add_all(commit)
    db.session.commit()
    return ""


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
@workattendance.route('/workattendance/queryAll',methods=['POST'])
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
            # 查询用户表所有数据
            queryData = Workattendance.query.filter_by()
            # 部门查找
            if departId != None and departId != "":
                queryData = queryData.filter(Workattendance.departId == departId)
            # 日期查找
            if dateTime != None and dateTime != "":
                queryData = queryData.filter(Workattendance.date == dateTime)
            # 状态查找
            if status != None and status != "":
                queryData = queryData.filter(Workattendance.status == status)
            # 关键字查找
            if searchValue != None and searchValue != "":
                queryData = queryData.filter(Workattendance.staffName.like("%" + searchValue + "%"))
             # 分页
            if pageSize != None and pageSize != "":
                pn = queryData.paginate(page=int(pageNo), per_page=pageSize, error_out=False)
            else:
                pn = queryData.paginate(page=int(pageNo), per_page=15, error_out=False)
            # 添加到dataList
            for item in pn:
                if(item.schema()["startTime"] or item.schema()["endTime"]):
                    startTime = item.schema()["startTime"].strftime('%H:%M:%S')
                    endTime = item.schema()["endTime"].strftime('%H:%M:%S')
                else:
                    startTime=""
                    endTime=""
                dataList.append({
                    "id":item.schema()["id"],
                    "staffId":item.schema()["staffId"],
                    "staffName":item.schema()["staffName"],
                    "date":item.schema()["date"].strftime('%Y-%m-%d'),
                    "startTime":startTime,
                    "endTime":endTime,
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
                    "total":pn.total,
                    'data':dataList
                }
            }) 
        elif departmentCheckingIn != -1:
            # 查询用户表所有数据
            queryData = Workattendance.query.filter_by()
            # 部门查找
            myDepartId = userData.schema()["departId"]
            queryData = queryData.filter(Workattendance.departId == myDepartId)
            # 日期查找
            if dateTime != None and dateTime != "":
                queryData = queryData.filter(Workattendance.date == dateTime)
            # 状态查找
            if status != None and status != "":
                queryData = queryData.filter(Workattendance.status == status)
            # 关键字查找
            if searchValue != None and searchValue != "":
                queryData = queryData.filter(Workattendance.staffName.like("%" + searchValue + "%"))
             # 分页
            if pageSize != None and pageSize != "":
                pn = queryData.paginate(page=int(pageNo), per_page=pageSize, error_out=False)
            else:
                pn = queryData.paginate(page=int(pageNo), per_page=15, error_out=False)
            # 添加到dataList
            for item in pn:
                if(item.schema()["startTime"] or item.schema()["endTime"]):
                    startTime = item.schema()["startTime"].strftime('%H:%M:%S')
                    endTime = item.schema()["endTime"].strftime('%H:%M:%S')
                else:
                    startTime=""
                    endTime=""
                dataList.append({
                    "id":item.schema()["id"],
                    "staffId":item.schema()["staffId"],
                    "staffName":item.schema()["staffName"],
                    "date":item.schema()["date"].strftime('%Y-%m-%d'),
                    "startTime":startTime,
                    "endTime":endTime,
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
    

# 修改考勤
# GET
# 接收的GET格式
"""
    # 状态
    status
    # id
    id
"""
@workattendance.route('/workattendance/edit',methods=['GET'])
@jwt_required()
def edit():
    try:
        # 状态
        status = request.args.get("status")
        # id
        id = request.args.get("id")
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
        editCheckingIn = userData.schema()["authority"].find("editCheckingIn")
        # 所有考勤
        if editCheckingIn != -1:
            # 修改状态
            Workattendance.query.filter(Workattendance.id == id).update({'status': status})
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

#获取前六个月的迟到的
@workattendance.route('/workattendance/monthChidao',methods=['GET'])
def monthChidao():
    dataList = []
    year = request.args.get("year")
    yearData = Workattendance.query.filter(Workattendance.date.like("%" + year + "%"))
    for i in range(12):
        if( i+1 < 10):
            like = year+'-'+'0'+str(i+1)
            dataList.append({
                "month":'0'+str(i+1),
                "count":yearData.filter(and_(Workattendance.status == "迟到",Workattendance.date.like("%" +like + "%"))).count()
            })
        else:
            like = year+'-'+str(i+1)
            dataList.append({
                "month":i+1,
                "count":yearData.filter(Workattendance.date.like("%" +like + "%")).count()
            })

    # 返回体
    return jsonify({
    #返回状态码
        "code": 200,
        #返回信息描述
        "message": "修改成功",
        #返回值
        "data": dataList
    }) 


#获取前六个月的的请假
@workattendance.route('/workattendance/monthQingjia',methods=['GET'])
def monthQingjia():
    dataList = []
    year = request.args.get("year")
    yearData = Workattendance.query.filter(Workattendance.date.like("%" + year + "%"))
    for i in range(12):
        if( i+1 < 10):
            like = year+'-'+'0'+str(i+1)
            dataList.append({
                "month":'0'+str(i+1),
                "count":yearData.filter(and_(Workattendance.status == "请假",Workattendance.date.like("%" +like + "%"))).count()
            })
        else:
            like = year+'-'+str(i+1)
            dataList.append({
                "month":i+1,
                "count":yearData.filter(and_(Workattendance.status == "请假",Workattendance.date.like("%" +like + "%"))).count()
            })

    # 返回体
    return jsonify({
    #返回状态码
        "code": 200,
        #返回信息描述
        "message": "修改成功",
        #返回值
        "data": dataList
    }) 
    

# 获取平均上班时间
@workattendance.route('/workattendance/avgTime',methods=['GET'])
def avgTime():
    dataList = []
    now = datetime.now()
    year = now.year
    month = now.month
    if(month < 10):
        strTime = str(year)+'-0'+str(month)
        yearData = Workattendance.query.filter(Workattendance.date.like("%" + strTime + "%"))
    else:
        strTime = str(year)+"-"+str(month)
        yearData = Workattendance.query.filter(Workattendance.date.like("%" + strTime + "%"))
    dataList.append({
        "name":"8:30之前",
        "value":yearData.filter(and_(Workattendance.startTime < "8:30",Workattendance.status != '请假')).count()
    })
    dataList.append({
        "name":"8:30-8:45",
        "value":yearData.filter(and_(Workattendance.startTime.between("8:30", "8:45"),Workattendance.status != '请假')).count()
    })
    dataList.append({
        "name":"8:45-9:00",
        "value":yearData.filter(and_(Workattendance.startTime.between("8:45", "9:00"),Workattendance.status != '请假')).count()
    })
    dataList.append({
        "name":"9:00-9:15",
        "value":yearData.filter(and_(Workattendance.startTime.between("9:00", "9:15"),Workattendance.status != '请假')).count()
    })
    dataList.append({
        "name":"9:15-9:30",
        "value":yearData.filter(and_(Workattendance.startTime.between("9:15", "9:30"),Workattendance.status != '请假')).count()
    })
    dataList.append({
        "name":"9:30之后",
        "value":yearData.filter(and_(Workattendance.startTime > "9:30",Workattendance.status != '请假')).count()
    })
    # 返回体
    return jsonify({
    #返回状态码
        "code": 200,
        #返回信息描述
        "message": "修改成功",
        #返回值
        "data": dataList
    })


# 获取各部门通勤率
@workattendance.route('/workattendance/avgDepart',methods=['GET'])
def avgDepart():
    departId = request.args.get("departId")
    dataList = []
    now = datetime.now()
    year = now.year
    month = now.month
    if(month < 10):
        strTime = str(year)+'-0'+str(month)
        yearData = Workattendance.query.filter(and_(Workattendance.date.like("%" + strTime + "%"),Workattendance.departId == departId))
    else:
        strTime = str(year)+"-"+str(month)
        yearData = Workattendance.query.filter(and_(Workattendance.date.like("%" + strTime + "%"),Workattendance.departId == departId))
    dataList.append({
        "name":"正常",
        "value":yearData.filter(Workattendance.status == '正常').count()
    })
    dataList.append({
        "name":"迟到",
        "value":yearData.filter(Workattendance.status == '迟到').count()
    })
    dataList.append({
        "name":"早退",
        "value":yearData.filter(Workattendance.status == '早退').count()
    })
    dataList.append({
        "name":"旷工",
        "value":yearData.filter(Workattendance.status == '旷工').count()
    })
    # 返回体
    return jsonify({
    #返回状态码
        "code": 200,
        #返回信息描述
        "message": "修改成功",
        #返回值
        "data": dataList
    }) 


# 获取今日请假人数
@workattendance.route('/workattendance/todayQJ',methods=['GET'])
def todayQJ():
    today = date.today()
    date_string = today.strftime("%Y-%m-%d")
    # 返回体
    return jsonify({
    #返回状态码
        "code": 200,
        #返回信息描述
        "message": "修改成功",
        #返回值
        "data": Workattendance.query.filter(and_(Workattendance.status == '请假',Workattendance.date == date_string)).count()
    }) 

# 获取今日上班人数
@workattendance.route('/workattendance/todaySB',methods=['GET'])
def todaySB():
    today = date.today()
    date_string = today.strftime("%Y-%m-%d")
    zc = Workattendance.query.filter(and_(Workattendance.status == '正常',Workattendance.date == date_string)).count()
    cd = Workattendance.query.filter(and_(Workattendance.status == '迟到',Workattendance.date == date_string)).count()
    # 返回体
    return jsonify({
    #返回状态码
        "code": 200,
        #返回信息描述
        "message": "修改成功",
        #返回值
        "data": zc+cd
    }) 

# 获取本月请假的人数
@workattendance.route('/workattendance/monthQJ',methods=['GET'])
def monthQJ():
    dataList = []
    today = date.today()
    date_string = today.strftime("%Y-%m")
    queryData = Workattendance.query.filter(and_(Workattendance.status == '请假',Workattendance.date.like("%" + date_string + "%")))
    for i in queryData:
        dataList.append(i.schema()["staffId"])
    # 返回体
    return jsonify({
    #返回状态码
        "code": 200,
        #返回信息描述
        "message": "修改成功",
        #返回值
        "data": len(list(set(dataList)))
    }) 







