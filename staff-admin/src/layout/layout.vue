<template>
    <div class="layout">
        <!-- 背景 -->
        <div class="moonBg " v-show="!themeType"></div>
        <div class="sunnyBg " v-show="themeType"></div>
        <el-container>
            <el-aside v-if="!isLoginView" class="aside">
                <CommonAside></CommonAside>
            </el-aside>
            <el-container style="width: 100%;">
                <el-header v-if="!isLoginView" class="header">
                    <CommonHeader></CommonHeader>
                </el-header>
                <el-main class="main">
                    <CommonTag v-if="!isLoginView"></CommonTag>
                    <el-config-provider :locale="zhCn">
                        <div class="container">
                            <router-view></router-view>
                        </div>
                    </el-config-provider>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>


<script setup>
import { computed } from 'vue'
// 头部组件
import CommonHeader from './components/CommonHeader.vue';
// 侧边栏组件
import CommonAside from './components/CommonAside.vue';
// 便签组件
import CommonTag from './components/CommonTag.vue';
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../stores/layout'
// 引入路由
import { useRoute } from "vue-router"

import zhCn from 'element-plus/dist/locale/zh-cn.mjs'


//路由
const route = useRoute()

// 获取layout仓库
const layoutStore = useLayoutStore()

// layout仓库的state数据
const {
    // 主题
    theme
} = storeToRefs(layoutStore)

// 判断是否在登录页
let isLoginView = computed(() => {
    return route.path === "/login"
})

//主题类型
let themeType = computed(() => {
    return theme.value === "light" ? true : false
})


</script>


<style lang="less" scoped>
.layout {
    position: relative;
    width: 100%;
    height: 100vh;
    background-size: 100%;
    background-repeat: no-repeat;
    background-attachment: fixed;
    overflow: hidden;

    .sunnyBg {
        position: absolute;
        top: 0;
        left: 0;
        z-index: -1;
        width: 100%;
        height: 100vh;
        background: url("../assets/bg/sun.png");
        background-size: 100%;
        background-repeat: no-repeat;
        background-attachment: fixed;
        background-position: center center;
    }

    .moonBg {
        position: absolute;
        top: 0;
        left: 0;
        z-index: -1;
        width: 100%;
        height: 100vh;
        background: url("../assets/bg/moon.png");
        background-size: 100%;

        background-repeat: no-repeat;
        background-attachment: fixed;
        background-position: center center;
    }

    .aside {
        width: auto;
        padding: 0;
        overflow: hidden !important;
    }

    .header {
        padding: 0;
    }

    .main {
        padding: 20px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;

        .container {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
    }
}
</style>
