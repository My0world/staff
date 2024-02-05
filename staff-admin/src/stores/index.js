//引入状态管理库
import { createPinia } from 'pinia'
//持久化插件
import piniaPersist from 'pinia-plugin-persist'
//创建状态管理库
const pinia = createPinia()
//使用持久化插件
pinia.use(piniaPersist)
// 暴露pinia
export default pinia