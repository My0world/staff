# 导入
from flask import Flask
# 数据库和跨域
from extension import db, cors
# 配置信息
import config
# 蓝图
from view.staff import staff
from view.department import department


# 配置app
app = Flask(__name__)
app.config.from_object(config)
db.init_app(app)
cors.init_app(app)


# 注册蓝图
# 员工表操作
app.register_blueprint(staff)
app.register_blueprint(department)


# 默认路由
@app.route('/')
def hello_world():
    return '闲人勿扰'


#创建表
@app.route('/createTable')
def createTable():
    with db.engine.connect() as conn:
        db.create_all()
    return '已创建表'

#删除所有的表
@app.route('/dropTable')
def dropTable():
    with db.engine.connect() as conn:
        db.drop_all()
    return '已删除所有表'



if __name__ == '__main__':
    app.run()
