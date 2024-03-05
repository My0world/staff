// 对axios进行二次封装 
import axios from "axios"
import { ElMessage, ElLoading } from 'element-plus'
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入login仓库
import { useLoginStore } from '../stores/login'
// 引入路由
import router from "../router"



// 1:利用axios对象方法create，去创建一个axios实例
// 2:request就是axios，只不过稍微配置一下
const requests = axios.create({

    //配置对象
    //基础路径
    baseURL: "http://127.0.0.1:5001",

    //代表请求超时的时间5s
    timeout: 5000
})
//请求拦截器：在发请求之前，请求拦截器可以检测到，可以在请求发出去之前做一些事情
requests.interceptors.request.use((config) => {
    // 获取login仓库
    const loginStore = useLoginStore()
    // 登录仓库的state数据
    const {
        // token
        token
    } = storeToRefs(loginStore)
    if (token.value) {
        config.headers['Authorization'] = "Bearer " + token.value
    }

    //config：配置对象，对象里面有一个属性很重要，header请求头
    return config
}, reject => {
    // 弹出错误信息
    ElMessage.error("系统错误，请通知管理员")
    //响应失败的回调函数，终止Promise链
    return Promise.reject(reject);

})

//响应拦截器
requests.interceptors.response.use(config => {
    const { code, message } = config.data
    if (code == 422) {
        ElMessage.error("身份已过期，请重新登录")
        useLoginStore().$reset()//清空仓库
        router.push({ path: "/login" })//跳转到登录
        return Promise.reject("身份已过期，请重新登录");
    }
    // 根据后端情况而定
    if (code == 200) {
        return config.data
    } else {
        ElMessage.error(message || "网络异常")
        return Promise.reject(message);
    }
}, reject => {
    if (reject.response) {
        if (reject.response.data.msg === "Missing Authorization Header") {
            ElMessage.error("请重新登录")
            useLoginStore().$reset()//清空仓库
            router.push({ path: "/login" })//跳转到登录
            return Promise.reject("请重新登录");
        }
        if (reject.response.data.msg === "Token has expired") {
            ElMessage.error("身份已过期，请重新登录")
            useLoginStore().$reset()//清空仓库
            router.push({ path: "/login" })//跳转到登录
            return Promise.reject("身份已过期，请重新登录");
        }
    } else {
        // 弹出错误信息
        ElMessage.error("服务器异常，请通知管理员")
        //响应失败的回调函数，终止Promise链
        return Promise.reject("服务器异常，请通知管理员");

    }

})

// 对外暴露
export default requests