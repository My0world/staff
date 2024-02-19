export default [
    {
        name: 'layout',//名字
        path: '/',//路径
        redirect: "/home",
        component: () => import('../layout/layout.vue'),//组件名称
        children: [
            //首页
            {
                name: 'home',//名字
                path: '/home',//路径
                component: () => import('../pages/Home/Home.vue'),//组件名称
                meta: {
                    title:"首页"
                },//路由元信息
            }, 


            //员工信息
            {
                name: 'staffMsg',//名字
                path: '/staffMsg',//路径
                component: () => import('../pages/Employees/StaffMsg.vue'),//组件名称
                meta: {
                    title:"信息管理"
                },//路由元信息
            }, {
                name: 'checkingIn',//名字
                path: '/checkingIn',//路径
                component: () => import('../pages/Employees/CheckingIn.vue'),//组件名称
                meta: {
                    title:"考勤管理"
                },//路由元信息
            }, 


            //通知管理
            {
                name: 'release',//名字
                path: '/release',//路径
                component: () => import('../pages/Notifications/Release.vue'),//组件名称
                meta: {
                    title:"发布通知"
                },//路由元信息
            }, {
                name: 'informHistory',//名字
                path: '/informHistory',//路径
                component: () => import('../pages/Notifications/InformHistory.vue'),//组件名称
                meta: {
                    title:"历史记录"
                },//路由元信息
            }, 


            //请假审核
            {
                name: 'leaveAudit',//名字
                path: '/leaveAudit',//路径
                component: () => import('../pages/Leave/LeaveAudit.vue'),//组件名称
                meta: {
                    title:"审核"
                },//路由元信息
            }, {
                name: 'leaveHistory',//名字
                path: '/leaveHistory',//路径
                component: () => import('../pages/Leave/LeaveHistory.vue'),//组件名称
                meta: {
                    title:"历史记录"
                },//路由元信息
            },


            //用户管理
            {
                name: 'userMsg',//名字
                path: '/userMsg',//路径
                component: () => import('../pages/User/UserMsg.vue'),//组件名称
                meta: {
                    title:"用户信息"
                },//路由元信息
            }, 
            {
                name: 'authority',//名字
                path: '/authority',//路径
                component: () => import('../pages/User/Authority.vue'),//组件名称
                meta: {
                    title:"权限管理"
                },//路由元信息
            }, 
            

            //操作内容审核
            {
                name: 'operatingRequestAudit',//名字
                path: '/operatingRequestAudit',//路径
                component: () => import('../pages/OperatingRequest/OperatingRequestAudit.vue'),//组件名称
                meta: {
                    title:"操作请求审核"
                },//路由元信息
            }, 
            
            
            
            //离职审核
            {
                name: 'dimissionAudit',//名字
                path: '/dimissionAudit',//路径
                component: () => import('../pages/Dimission/DimissionAudit.vue'),//组件名称
                meta: {
                    title:"审核"
                },//路由元信息
            }, {
                name: 'dimissionData',//名字
                path: '/dimissionData',//路径
                component: () => import('../pages/Dimission/DimissionData.vue'),//组件名称
                meta: {
                    title:"离职员工表"
                },//路由元信息
            }, 
            

            //操作记录
            {
                name: 'operatingData',//名字
                path: '/operatingData',//路径
                component: () => import('../pages/OperatingData/OperatingData.vue'),//组件名称
                meta: {
                    title:"操作记录"
                },//路由元信息
            }, 
            

            //反馈消息
            {
                name: 'feedback',//名字
                path: '/feedback',//路径
                component: () => import('../pages/Feedback/Feedback.vue'),//组件名称
                meta: {
                    title:"反馈消息"
                },//路由元信息
            },

            //登录
            {
                name: 'login',//名字
                path: '/login',//路径
                component: () => import('../pages/Login/Login.vue'),//组件名称
                meta: {},//路由元信息
            }
        ],//二级路由
    }, {
        name: '404',//名字
        path: '/404',//路径
        component: () => import('../pages/404/404.vue'),//组件名称
        meta: {},//路由元信息
    },{
        name: '403',//名字
        path: '/403',//路径
        component: () => import('../pages/403/403.vue'),//组件名称
        meta: {},//路由元信息
    },
]