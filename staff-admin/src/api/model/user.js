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

    //分配权限
    reqAllotAuthority: (data) => request({
        url: `/admin_user/allotAuth`,
        method: 'POST',
        data
    }),

    // 查看密码
    reqShowPassWord: (data) => request({
        url: `/admin_user/showPassWord`,
        method: 'POST',
        data
    }),

    // 修改密码
    reqUpdatePassWord: (data) => request({
        url: `/admin_user/updatePassWord`,
        method: 'POST',
        data
    }),

    // 删除用户
    reqDeleteUser: (data) => request({
        url: `/admin_user/deleteUser`,
        method: 'POST',
        data
    }),

    // 选择员工
    reqSearchStaff: (keyValue) => request({
        url: `/staff/search?keyValue=${keyValue}`,
        method: 'GET',
    }),

    // 添加用户
    reqAddUser: (data) => request({
        url: `/admin_user/addAdmin`,
        method: 'POST',
        data
    }),
    
}