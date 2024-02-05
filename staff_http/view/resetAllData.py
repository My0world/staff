from flask import Blueprint
from extension import db
from flask import jsonify

resetAllData = Blueprint('resetAllData',__name__)

# 默认路由
@resetAllData.route('/')
def hello_world():
    return '闲人勿扰'


# 重置数据
# GET
@resetAllData.route('/resetAllData/createTable',methods=['GET'])
def createTable():
    with db.engine.connect() as conn:
        db.create_all()
        return jsonify({           
            #返回状态码
            "code": 200,
            #返回信息描述
            "message": "创建",
        })


# 删除所有的表
# GET
@resetAllData.route('/resetAllData/dropTable',methods=['GET'])
def dropTable():
    with db.engine.connect() as conn:
        db.drop_all()
    return '已删除所有表'


    
     
        