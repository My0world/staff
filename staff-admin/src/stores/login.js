import {
    defineStore
} from "pinia"
import login from "../api/index"
import socket from "../util/socket"


import Cookies from 'js-cookie'

const cookiesStorage = {
    //设置token
    setItem(key, state) {
        let seconds = 900;
        let expires = new Date(new Date() * 1 + seconds * 1000);
        return Cookies.set(key, state, { expires: expires })
    },
    //获取token
    getItem(key) {
        return Cookies.get(key)
    }
}


export const useLoginStore = defineStore("login", {
    state: () => ({
        token: null,//token
        authorityList: [],//权限表
        staffName: null,//用户名
        staffId:null, //用户id
        departId:null,//部门id
    }),
    getters: {

    },
    actions: {
        //发送反馈消息
        async sendFeedbackForm(data) {
            // 发送请求
            let res = await login.reqFeedbackPost({
                send_staffId: data.staffId,
                content: data.content,
            })
            return res.message
        },
        
        //发送登录信息
        async sendLoginForm(data) {
            // 发送请求
            let res = await login.reqLogin({
                "staffId": data.staffId,
                "password": data.password
            }).then(reslove => {
                //发送socket（已登陆）
                socket.emit("admin_user","")
                return reslove
            })
            // 存储数据
            this.token = res.data.token;
            this.authorityList = res.data.authority.split(',');
            this.staffId = res.data.staffId
            this.departId = res.data.departId
            this.staffName = res.data.staffName;
            
            let index = this.authorityList.findIndex(item => {
                return item === "allAdminUserView"
            })


            //保存token
            return res.message
        },

        //设置为下线状态
        async setLogoutStatus() {
            // 发送请求
            let res = await login.reqLogout().then(reslove => {
                //发送socket（退出登陆）
                socket.emit("admin_user","")
                return reslove
            })
            // 清除保存的信息
            this.resetToken()
            return res.message
        },
        resetToken() {
            //删除cookie
            this.$reset()
        }
    },
    persist: {
        enabled: true,
        strategies: [
            {
                storage: cookiesStorage,
                key: 'token',
                paths: ['token']
            },
            {
                storage: cookiesStorage,
                key: 'authorityList',
                paths: ['authorityList']
            },
            {
                storage: cookiesStorage,
                key: 'staffName',
                paths: ['staffName']
            },
            {
                storage: cookiesStorage,
                key: 'staffId',
                paths: ['staffId']
            },
            {
                storage: cookiesStorage,
                key: 'departId',
                paths: ['departId']
            }
        ],
    },
})