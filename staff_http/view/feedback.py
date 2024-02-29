from flask import Blueprint
from extension import db
from models import Feedback,Staff
from flask import jsonify
from flask import request
from until import getDate

feedback = Blueprint('feedback',__name__)

# 发送反馈内容
# 接收的Post格式
# {
#     # 发送方员工ID
#     send_staffId,
#     # 接受方员工ID
#     receiver_staffId,
#     # 反馈内容
#     content
# }
@feedback.route('/feedback/feedbackPost',methods=['POST'])
def feedbackPost():
    try:
        # 获取post数据
        send_staffId = request.json.get('send_staffId')
        receiver_staffId = request.json.get('receiver_staffId')
        content = request.json.get('content')

        # 查找是否有该用户
        staff = Staff.query.filter(Staff.staffId == send_staffId).first(),
        if staff[0] == None:
            # 用户不存在
            return jsonify({           
                #返回状态码
                "code": 401,
                #返回信息描述
                "message": "员工号错误，请确认员工号是否正确",
                #返回值
                "data": {}
            })
        msg = Feedback(send_staffId = send_staffId, receiver_staffId = receiver_staffId, content = content, dateTime = getDate())
        db.session.add_all([msg])
        db.session.commit()
        # 返回体
        return jsonify({
            #返回状态码
            "code": 200,
            #返回信息描述
            "message": "提交成功，稍后管理员会进行处理",
            #返回值
            "data": ""
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


