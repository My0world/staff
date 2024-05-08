/**
 * 员工api的管理
 */
import request from '../request'
export default {
    //部门信息
    reqDepartmentList: () => request({
        url: "/department/queryAll",
        method: 'get',
    }),

    //职位类型
    reqJobType: () => request({
        url: "/staff/jobType",
        method: 'get',
    }),

    //筛选员工信息
    reqStaffData: (params) => request({
        url: "/staff/filterAll",
        method: 'post',
        data: params
    }),

    //添加员工信息
    reqAddStaff: (params) => request({
        url: "/staff/addStaff",
        method: 'post',
        data: params
    }),

    //修改员工信息
    reqUpdateStaff: (params) => request({
        url: "/staff/updateStaff",
        method: 'post',
        data: params
    }),

    //设置为离职员工
    reqResignStaff: (params) => request({
        url: "/resign/resignStaff",
        method: 'post',
        data: params
    }),

    //考勤数据
    reqCheckingInData: (params) => request({
        url: "/workattendance/queryAll",
        method: 'post',
        data: params
    }),

    //修改考勤数据
    reqEditCheckingIn: (params) => request({
        url: `/workattendance/edit?id=${params.id}&status=${params.status}`,
        method: 'GET',
    }),

    //请假数据
    reqAskforleaveData: (params) => request({
        url: "/askforleave/queryAll",
        method: 'post',
        data: params
    }),

    //考勤数据
    reqEditAskforleave: (opid, status) => request({
        url: `/askforleave/updateStatus?opid=${opid}&status=${status}`,
        method: 'get',
    }),

    //今日请假
    reqtodayQJ: () => request({
        url: `/workattendance/todayQJ`,
        method: 'get',
    }),

    //今日上班
    reqtodaySB: () => request({
        url: `/workattendance/todaySB`,
        method: 'get',
    }),

    //本月请假
    reqmonthQJ: () => request({
        url: `/workattendance/monthQJ`,
        method: 'get',
    }),

    //每个月迟到
    reqmonthChidao: () => request({
        url: `/workattendance/monthChidao?year=2024`,
        method: 'get',
    }),

    //每个月请假
    reqmonthQingjia: () => request({
        url: `/workattendance/monthQingjia?year=2024`,
        method: 'get',
    }),

    //平均到达时间
    reqAvgTime: () => request({
        url: `/workattendance/avgTime`,
        method: 'get',
    }),

    //各部门通勤率
    reqAvgDepart: (departId) => request({
        url: `/workattendance/avgDepart?departId=${departId}`,
        method: 'get',
    }),
}