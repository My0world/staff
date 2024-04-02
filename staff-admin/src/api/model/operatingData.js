/**
 * 员工api的管理
 */
import request from '../request'
export default {
    //筛选操作记录信息
    reqOperatingData: ({ startTime, endTime, searchText, pageNo }) => request({
        url: `/admin_op_record/filterAll?startTime=${startTime}&endTime=${endTime}&searchText=${searchText}&pageNo=${pageNo}`,
        method: 'GET',
    }),
}