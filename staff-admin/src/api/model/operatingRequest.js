/**
 * 登录和退出登录api的管理
 */
import request from '../request'
export default {
    //发送反馈信息
    reqOpReviewData: (status,pageNo) => request({
        url: `/admin_op_review/filterAll?status=${status}&pageNo=${pageNo}`,
        method: 'GET',
    }),
}