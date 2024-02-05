from flask import Flask
from flask_socketio import SocketIO
from flask_socketio import send, emit
# token
from flask_jwt_extended import JWTManager,jwt_required

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app, cors_allowed_origins='*')
jwt = JWTManager(app)



# 用户连接
@socketio.on('connect')
def test_connect():
    print("用户已连接")


# 用户登录
@socketio.on('userLogin')
def userLogin(data):
    emit('userLoginEvent', {'code':'userUpdate','msg': '有用户登录了'},broadcast=True)
    print("用户登录")


# 用户退出登录
@socketio.on('userLogout')
def userLogout(data):
    emit('userLogoutEvent', {'code':'userUpdate','msg': '有用户退出登录了'},broadcast=True)
    print("用户退出登录")


# 用户取消连接
@socketio.on('disconnect')
def test_disconnect():
    print('取消连接')





if __name__ == '__main__':
    socketio.run(app)