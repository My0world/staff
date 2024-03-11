/**
 * 登录和退出登录api的管理
 */
import request from '../request'
export default {
    //发送反馈信息
    reqFeedbackPost: (params) => request({
        url: "/feedback/feedbackPost",
        method: 'post',
        data: params
    }),

    //发送登录信息
    reqLogin: (params) => request({
        url: "/admin_user/login",
        method: 'post',
        data: params
    }),

    //退出登录
    reqLogout: () => request({
        url: "/admin_user/logout",
        method: 'get',
    }),
}