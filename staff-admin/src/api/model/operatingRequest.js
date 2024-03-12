/**
 * 操作请求审核api的管理
 */
import request from '../request'
export default {
    //发送反馈信息
    reqOpReviewData: (status, pageNo) => request({
        url: `/admin_op_review/filterAll?status=${status}&pageNo=${pageNo}`,
        method: 'GET',
    }),

    //审核驳回
    reqCheckReject: (id) => request({
        url: `/admin_op_review/checkReject?id=${id}`,
        method: 'GET',
    }),
}