# 导入
from flask import Flask
# 数据库和跨域
from extension import db, cors
# 配置信息
import config
# 蓝图
from view.staff import staff
from view.department import department
from view.admin_user import admin_user
from view.feedback import feedback
from view.resetAllData import resetAllData
from view.admin_authority import admin_authority
# token
from flask_jwt_extended import JWTManager
# 定时任务
from setting import scheduler,app



# 注册蓝图
app.register_blueprint(staff)
app.register_blueprint(feedback)
app.register_blueprint(admin_user)
app.register_blueprint(department)
app.register_blueprint(resetAllData)
app.register_blueprint(admin_authority)


if __name__ == '__main__':
    scheduler.start()
    app.run(debug=True, port=5001)
    
