<template>
    <div class="OperatingData">
        <el-row :gutter="20" class="container">
            <el-col :span="24" style="height: 100%;">
                <SearchCard></SearchCard>
            </el-col>
        </el-row>
        <el-row :gutter="20" class="container">
            <el-col :span="24" style="height: 100%;">
                <OperatingList></OperatingList>
            </el-col>
        </el-row>
    </div>
</template>


<script setup>
import { onMounted } from 'vue';
import SearchCard from './components/SearchCard.vue';
import OperatingList from './components/OperatingList.vue';
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入login仓库
import { useLoginStore } from '../../stores/login'
// 路由
import { useRouter } from 'vue-router'

//使用路由
let router = useRouter()

// 获取login仓库
let loginStore = useLoginStore()

// login仓库的state数据
const {
    //权限列表
    authorityList,
} = storeToRefs(loginStore)

onMounted(() => {
    if (authorityList.value.indexOf("operatingData") === -1) {
        router.push({ name: '403' })
    }
})


</script>


<style scoped lang="less">
.OperatingData {
    margin-top: 17px;
    height: calc(100% - 17px);

    .container {
        overflow-y: auto;
        padding: 10px;
        padding-bottom: 0px;
        box-sizing: border-box;
        &:nth-last-of-type(1){
            padding-top: 10px;
            height: calc(100% - 140px);
            padding-bottom: 10px;
        }
    }
}
</style>
