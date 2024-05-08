<template>
    <div class="Notice">
        <el-tabs v-model="activeName" type="card" :class="[theme === 'light' ? 'light' : 'dark']">
            <el-tab-pane label="写通知" name="写通知">
                <div class="block" v-if="activeName === '写通知'">
                    <noticeForm></noticeForm>
                </div>
            </el-tab-pane>
            <el-tab-pane label="已发送" name="已发送">
                <div class="block" v-if="activeName === '已发送'">
                    <send></send>
                </div>
            </el-tab-pane>
            <el-tab-pane label="收件箱" name="收件箱">
                <div class="block" v-if="activeName === '收件箱'">
                    <receive></receive>
                </div>
            </el-tab-pane>

        </el-tabs>
    </div>
</template>



<script setup>
import noticeForm from './components/noticeForm.vue';
import send from './components/send.vue';
import receive from './components/receive.vue';

import { onMounted, provide, ref } from 'vue';
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

// 获取login仓库
let loginStore = useLoginStore()

// 使用layout仓库
let layoutStore = useLayoutStore()

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

//标签页点击的值
let activeName = ref('写通知')
provide("activeName", activeName)

// login仓库的state数据
const {
    //权限列表
    authorityList,
} = storeToRefs(loginStore)

onMounted(() => {
    if (authorityList.value.indexOf("notice") === -1) {
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
.Notice {
    margin-top: 17px;
    height: calc(100% - 17px);


    :deep(.el-tabs) {
        height: 100%;

        .el-tabs__content {
            height: calc(100% - 52.5px);

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
            height: calc(100% - 140px);
            padding-bottom: 10px;
        }
    }
}
</style>
