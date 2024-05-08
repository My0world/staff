/**
 * 登录和退出登录api的管理
 */
import request from '../request'
export default {
    //发送通知
    reqIssueNotice: (params) => request({
        url: "/notice/issue",
        method: 'post',
        data: params
    }),

    //已发送
    reqSendData: ({ searchText, pageNo }) => request({
        url: `/notice/send?searchText=${searchText}&pageNo=${pageNo}`,
        method: 'get',
    }),

    //已接收
    reqReceiverData: ({ searchText, pageNo }) => request({
        url: `/notice/receiver?searchText=${searchText}&pageNo=${pageNo}`,
        method: 'get',
    }),
}