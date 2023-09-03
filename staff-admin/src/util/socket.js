import io from 'socket.io-client';

let socket = null

socket = io('http://127.0.0.1:5000');



socket.on('updataAdminStatus', data => {
    console.log(data);
});

export default socket


