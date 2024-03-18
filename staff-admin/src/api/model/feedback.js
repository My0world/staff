/**
 * 员工api的管理
 */
import request from '../request'
export default {
    //筛选员工信息
    reqFeedbackData: ({ startTime, endTime, searchText, pageNo }) => request({
        url: `/feedback/filterAll?startTime=${startTime}&endTime=${endTime}&searchText=${searchText}&pageNo=${pageNo}`,
        method: 'GET',
    }),
}