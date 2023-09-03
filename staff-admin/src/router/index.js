// 配置路由

// 引入VueRouter
import * as VueRouter from 'vue-router'

// 引入页面组件
import routes from "./routes"

//创建路由
export default VueRouter.createRouter({
    history:VueRouter.createWebHashHistory(),
    routes
})