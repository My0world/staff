# 导入
import datetime
from flask import Flask
# 数据库和跨域
from extension import db, cors
# 配置信息
import config
# token
from flask_jwt_extended import JWTManager
# redis
from flask_redis import FlaskRedis
# 定时任务
from flask_apscheduler import APScheduler





# 配置app
app = Flask(__name__)
app.config.from_object(config)
app.config['JWT_SECRET_KEY'] = 'super-secret'
app.config['JWT_BLACKLIST_ENABLED'] = True  # 启用 token 黑名单功能
app.config['JWT_BLACKLIST_TOKEN_CHECKS'] = ['access']  # 只对 access token 进行黑名单检查
app.config['REDIS_URL'] = 'redis://:123456@localhost:6379/0'
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = datetime.timedelta(minutes=15)


scheduler = APScheduler()
db.init_app(app)
cors.init_app(app)
jwt = JWTManager(app)
redis_client = FlaskRedis(app)
