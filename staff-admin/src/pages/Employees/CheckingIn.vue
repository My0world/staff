<template>
    <div class="CheckingIn">
        <el-tabs v-model="activeName" type="card" :class="[theme === 'light' ? 'light' : 'dark']">
            <el-tab-pane label="考勤表" name="考勤表">
                <div class="block" v-if="activeName === '考勤表'">
                    <el-row :gutter="20" class="container">
                        <el-col :span="24" style="height: 100%;">
                            <CheckingInSearch></CheckingInSearch>
                        </el-col>
                    </el-row>
                    <el-row :gutter="20" class="container">
                        <el-col :span="24" style="height: 100%;">
                            <CheckingInTable></CheckingInTable>
                        </el-col>
                    </el-row>
                </div>
            </el-tab-pane>
            <el-tab-pane label="请假审核" name="请假审核">
                <div class="block" v-if="activeName === '请假审核'">
                    <el-row :gutter="20" class="container">
                        <el-col :span="24" style="height: 100%;">
                            <VacationSearch></VacationSearch>
                        </el-col>
                    </el-row>
                    <el-row :gutter="20" class="container">
                        <el-col :span="24" style="height: 100%;">
                            <VactionTable></VactionTable>
                        </el-col>
                    </el-row>
                </div>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>


<script setup>
import { ref,provide,onMounted, computed } from 'vue';
import CheckingInSearch from './components/CheckingInSearch.vue';
import CheckingInTable from './components/CheckingInTable.vue';
import VacationSearch from './components/VacationSearch.vue';
import VactionTable from './components/VactionTable.vue';

// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入login仓库
import { useLoginStore } from '../../stores/login'
// 引入layout仓库
import { useLayoutStore } from '../../stores/layout'
// 路由
import { useRouter } from 'vue-router'


//使用路由
let router = useRouter()

//标签页点击的值
let activeName = ref('考勤表')
provide("activeName",activeName)

// 获取login仓库
let loginStore = useLoginStore()

// 使用layout仓库
let layoutStore = useLayoutStore()

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



onMounted(() => {
    if (authorityList.value.indexOf("checkingIn") === -1) {
        router.push({ name: '403' })
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
.CheckingIn {
    margin-top: 17px;
    height: calc(100% - 17px) ;
    

    :deep(.el-tabs) {
        height: 100%;

        .el-tabs__content {
            height: calc( 100% - 52.5px);

            .el-tab-pane {
                height: 100%;
            }
        }
    }
}
.block {
    margin-top: 17px;
    height: calc(100% - 17px);

    .container {
        overflow-y: auto;
        padding: 10px;
        padding-bottom: 0px;
        box-sizing: border-box;

        &:nth-last-of-type(1) {
            padding-top: 10px;
            height: calc(100% - 185px);
            padding-bottom: 10px;
        }
    }
}
</style>
