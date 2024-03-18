/**
 * 操作请求审核api的管理
 */
import request from '../request'
export default {
    //获取操作请求信息
    reqDimissionAuditData: (status, pageNo) => request({
        url: `/resignreview/filterAll?status=${status}&pageNo=${pageNo}`,
        method: 'GET',
    }),

    //审核
    reqUpdateStatus: (params) => request({
        url: `/resignreview/updateStatus`,
        method: 'POST',
        data: params
    }),

    //筛选员工信息
    reqDimissionData: (params) => request({
        url: "/resign/filterAll",
        method: 'post',
        data: params
    }),

    //筛选员工信息
    reqReturnStaff: (id) => request({
        url: `/resign/returnStaff?resignStaffId=${id}`,
        method: 'get',
    }),
}