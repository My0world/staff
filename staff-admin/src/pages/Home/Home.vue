<template>
    <div class="Home">
        <el-row :gutter="14" style="overflow: hidden">
            <el-col :span="12">
                <el-row :gutter="14">
                    <el-col :span="12">
                        <UserMsg></UserMsg>
                    </el-col>
                    <el-col :span="12">
                        <OtherMsg mykey="今日请假人数" :msg="todayQJ+'人'"></OtherMsg>
                    </el-col>
                    <el-col style="padding:20px 14px " :span="24">
                        <cdLineCard></cdLineCard>
                    </el-col>
                    <el-col :span="24" style="padding:0px 14px;margin-bottom: 10px">
                        <AvgTimePieCard></AvgTimePieCard>
                    </el-col>
                </el-row>
                
            </el-col>
            <el-col :span="12">
                <el-row :gutter="14">
                    <el-col :span="12">
                        <OtherMsg mykey="今日上班人数" :msg="todaySB+'人'"></OtherMsg>
                    </el-col>
                    <el-col :span="12">
                        <OtherMsg mykey="本月请假人数" :msg="monthQJ+'人'"></OtherMsg>
                    </el-col>
                    <el-col style="padding:20px 14px " :span="24">
                        <qjLineCard></qjLineCard>
                    </el-col>
                    <el-col :span="24" style="padding:0px 14px;margin-bottom: 10px">
                        <AvgDepartPieCard></AvgDepartPieCard>
                    </el-col>
                </el-row>
            </el-col>
        </el-row>
    </div>
</template>


<script setup>
import UserMsg from "./components/UserMsg.vue"
import OtherMsg from "./components/OtherMsg.vue"
import cdLineCard from "./components/cdLineCard.vue"
import qjLineCard from "./components/qjLineCard.vue"
import AvgTimePieCard from "./components/AvgTimePieCard.vue"
import AvgDepartPieCard from "./components/AvgDepartPieCard.vue"

import { onMounted,ref } from 'vue';

//API
import employees from '../../api'

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

//今日请假
let todayQJ = ref(null)

//今日上班
let todaySB = ref(null)

//本月请假
let monthQJ = ref(null)

// login仓库的state数据
const {
    //权限列表
    authorityList,
} = storeToRefs(loginStore)

onMounted(() => {
    if (authorityList.value.indexOf("home") === -1) {
        router.push({ name: '403' })
    }
    Promise.all([employees.reqtodayQJ(),employees.reqtodaySB(),employees.reqmonthQJ()]).then((res)=>{
        todayQJ.value = res[0].data
        todaySB.value = res[1].data
        monthQJ.value = res[2].data
    })
})

</script>


<style lang="less" scoped>

.Home {
    margin-top: 17px;
    overflow: hidden;
    overflow-y: auto;
}
</style>
