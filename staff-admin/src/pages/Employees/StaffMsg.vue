<template>
    <div class="StaffMsg">
        <SearchCard></SearchCard>
        <StaffMsgTable></StaffMsgTable>
    </div>
</template>


<script setup>
import { onMounted } from 'vue';
import SearchCard from './components/SearchCard.vue';
import StaffMsgTable from './components/StaffMsgTable.vue';
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
    if(authorityList.value.indexOf("staffMsg") === -1){
        router.push({name:'403'})
    }
})


</script>


<style scoped lang="less">
.StaffMsg {
    margin-top: 17px;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
}
</style>

