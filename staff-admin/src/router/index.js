
// 引入VueRouter
import * as VueRouter from 'vue-router'
// 引入页面组件
import routes from "./routes"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入login仓库
import { useLoginStore } from '../stores/login'

//创建路由
const router = VueRouter.createRouter({
    history: VueRouter.createWebHashHistory(),
    routes
})

// 路由前置守卫
router.beforeEach((to, from, next) => {
    // 获取login仓库
    const loginStore = useLoginStore()
    // 登录仓库的state数据
    const {
        // token
        token,
        // 权限表
    } = storeToRefs(loginStore)
    if(to.path === '/login'){
        if(token.value){
            
            //不可以去登录页，跳回原来的页面
            next(from.path)
        }else{
            //如果没有token
            //可以去登录页
            next()
        }
    }else{
        if(!token.value){
            //如果没有token
            //强制跳到登录页
            next('/login')
        }else{
            //如果有token
            //查找是否有该页面
            let index = router.getRoutes().findIndex((item)=>{
                return item.path === to.path
            })
            
            if (index === -1){
                //如果路由没有该页面则跳到404页面
                next("/404")
            }else{
                //如果路由有该页面则跳转
                next()
            }
        }
    }

})

export default router