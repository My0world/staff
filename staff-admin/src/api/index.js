/**
 * 整个项目api的管理
 */
import request from './request'

//发送反馈信息
export const reqFeedbackPost = (params) => request({
    url: "/feedback/feedbackPost",
    method: 'post',
    data: params
})

//发送登录信息
export const reqLogin = (params) => request({
    url: "/admin_user/login",
    method: 'post',
    data: params
})

//退出登录
export const reqLogout = () => request({
    url: "/admin_user/logout",
    method: 'get',
})

//部门信息
export const reqDepartmentList = () => request({
    url: "/department/queryAll",
    method: 'get',
})

//职位类型
export const reqJobType = () => request({
    url: "/staff/jobType",
    method: 'get',
})

//筛选员工信息
export const reqStaffData = (params) => request({
    url: "/staff/filterAll",
    method: 'post',
    data: params
})
