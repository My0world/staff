<template>
    <div class="User">
        <h1>用户管理</h1>
    </div>
</template>


<script setup>
import { onMounted } from 'vue';
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入login仓库
import { useLoginStore } from '../../stores/login'
// 路由
import {useRouter} from 'vue-router'

//使用路由
let router = useRouter()

// 获取login仓库
let loginStore = useLoginStore()

// login仓库的state数据
const {
    //权限列表
    authorityList,
} = storeToRefs(loginStore)

onMounted(()=>{
    if(authorityList.value.indexOf("user") === -1){
        router.push({name:'403'})
    }
})
</script>


<style>
    .User{
        
    }
</style>

