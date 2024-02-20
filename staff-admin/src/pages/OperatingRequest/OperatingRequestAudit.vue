<template>
    <div class="OperatingRequestAudit">
        <el-tabs v-model="activeName" type="card" :class="[theme === 'light' ? 'light' : 'dark']" @tab-click="handleClick">
            <el-tab-pane label="全部" name="first">User</el-tab-pane>
            <el-tab-pane label="待审核" name="second">Config</el-tab-pane>
            <el-tab-pane label="审核通过" name="third">Role</el-tab-pane>
            <el-tab-pane label="审核驳回" name="fourth">Task</el-tab-pane>
        </el-tabs>
    </div>
</template>


<script setup>
import { ref, computed, onMounted, getCurrentInstance } from 'vue';
// 引入layout仓库
import { useLayoutStore } from '../../stores/layout'
// 引入login仓库
import { useLoginStore } from '../../stores/login'
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 路由
import {useRouter} from 'vue-router'

//使用路由
let router = useRouter()

//标签页点击的值
let activeName = ref('second')

// 使用layout仓库
let layoutStore = useLayoutStore()

// 获取login仓库
let loginStore = useLoginStore()

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// login仓库的state数据
const {
    //权限列表
    authorityList,
} = storeToRefs(loginStore)

onMounted(()=>{
    if(authorityList.value.indexOf("operatingRequestAudit") === -1){
        router.push({name:'403'})
    }
})

</script>

<!-- elementUI -->
<style lang="less" scoped>
:deep(.light) {
    .el-tabs__nav {
        border: 1px solid rgba(0, 0, 0, 0.3);
        border-bottom: none;
    }

    .el-tabs__header {
        border-bottom: 1px solid rgba(0, 0, 0, 0.3) !important;
    }

    .el-tabs__item:nth-of-type(1) {
        border-left: none !important;
    }

    .el-tabs__item {
        font-size: 0.07813rem;
        color: #333;
        border-left: 1px solid rgba(0, 0, 0, 0.3) !important;
    }

    .is-active {
        font-size: 0.07813rem;
        border-bottom: none;
        color: #409eff;
    }
}
:deep(.dark) {
    .el-tabs__nav {
        border: 1px solid rgba(255, 255, 255, 0.3);
        border-bottom: none;
    }

    .el-tabs__header {
        border-bottom: 1px solid rgba(255, 255, 255, 0.3) !important;
    }

    .el-tabs__item:nth-of-type(1) {
        border-left: none !important;
    }

    .el-tabs__item {
        font-size: 0.07813rem;
        color: #ebeaea;
        border-left: 1px solid rgba(255, 255, 255, 0.3) !important;
    }

    .is-active {
        font-size: 0.07813rem;
        border-bottom: none;
        color: #409eff;
    }

}
</style>
<style lang="less" scoped>
.OperatingRequestAudit {
    margin-top: 17px;
}
</style>

