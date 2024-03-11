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
    })
    ,

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
    })

}