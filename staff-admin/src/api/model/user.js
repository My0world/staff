/**
 * 用户管理
 */
import request from '../request'
export default {
    //发送反馈信息
    reqAuthorityData: () => request({
        url: `/admin_authority/allData`,
        method: 'GET',
    }),

    //筛选用户信息
    reqUserData: ({ status, departId, pageNo }) => request({
        url: `/admin_user/queryAll?status=${status}&departId=${departId}&pageNo=${pageNo}`,
        method: 'GET',
    }),
}