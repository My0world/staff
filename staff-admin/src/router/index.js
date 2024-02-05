
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
        token
    } = storeToRefs(loginStore)
    if(to.path === '/login'){
        if(token.value){
            next(from.path)
        }else{
            next()
        }
    }else{
        if(!token.value){
            next('/login')
        }else{
            let index = router.getRoutes().findIndex((item)=>{
                return item.path === to.path
            })
            if (index === -1){
                next("/404")
            }else{
                next()
            }
            console.log(object);
        }
    }

})

export default router