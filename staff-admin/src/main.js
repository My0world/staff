//创建app
import { createApp } from 'vue'
import App from './App.vue'
//引入状态管理器
import pinia from './stores';
//引入适配em
import 'amfe-flexible';
//引入element的icon图标
import 'element-plus/dist/index.css'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
//引入element方法
import { ElMessage } from 'element-plus'
//引入路由
import router from './router'
//引入全局组件
import ThemeSwitch from "./components/ThemeSwitch.vue"
import Dialog from "./components/Dialog.vue"
import Card from "./components/Card.vue"
//animate动画
import 'animate.css';
// 引入api
import * as API from './api'
// 引入socket
import "./util/socket"
// 去除默认样式
import "./assets/reset.css"
//echarts
import * as echarts from "echarts";




//创建app
const app = createApp(App)


// 全局挂载消息提示
app.config.globalProperties.$ElMessage = ElMessage
// 全局挂载API
app.config.globalProperties.$API = API
// 全局挂载 echarts
app.config.globalProperties.$echarts = echarts;

//使用全局组件
app.component("ThemeSwitch", ThemeSwitch)
app.component("Dialog", Dialog)
app.component("Card", Card)
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
