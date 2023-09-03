# Mysql所在的主机名
HOSTNAME = '127.0.0.1'
# Mysql监听端口号，默认3306
PORT = 3306
# 密码
PASSWORD = 'root'
# 用户名
USERNAME = 'root'
# 数据库名称
DATABASE = 'staff_manage'

# 连接数据库
SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://{USERNAME}:{PASSWORD}@{HOSTNAME}:{PORT}/{DATABASE}?charset=utf8mb4"
SQLALCHEMY_TRACK_MODIFICATIONS= False  # 动态追踪修改设置，如果设置只会提醒警告，不建议开启
SQLALCHEMY_ECHO = True  # 查询时会显示原始sql语句
SQLALCHEMY_COMMIT_TEARDOWN = True 
SQLALCHEMY_TRACK_MODIFICATIONS = True 
SQLALCHEMY_COMMIT_ON_TEARDOWN = True 