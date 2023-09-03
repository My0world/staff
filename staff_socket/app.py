from flask import Flask
from flask_socketio import SocketIO
from flask_socketio import send, emit

app = Flask(__name__)
app.config['SECRET_KEY'] = 'secret!'
socketio = SocketIO(app, cors_allowed_origins='*')





@socketio.on('connect')
def test_connect():
    emit('updataAdminStatus', {'data': '用户状态更新'},broadcast=True)
    print('连接成功')

@socketio.on('disconnect')
def test_disconnect():
    print('取消连接')

@socketio.on('sendNotice')
def sendNotice(data):
    print(data)


if __name__ == '__main__':
    socketio.run(app)