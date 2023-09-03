//创建app
import { createApp } from 'vue'
import App from './App.vue'
//引入适配em
import 'amfe-flexible';
//引入element的icon图标
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
//引入路由
import router from './router'
//引入状态管理库
import { createPinia } from 'pinia'



//创建app
const app = createApp(App)
//创建状态管理库
const pinia = createPinia()

//使用路由状态管理库
app.use(pinia)
//使用路由
app.use(router)

//添加ElementIcons图标组件
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
}



//渲染app
app.mount('#app')
