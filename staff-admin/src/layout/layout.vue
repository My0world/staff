<template>
    <div class="layout">
        <el-container>
            <el-aside class="aside">
                <CommonAside></CommonAside>
            </el-aside>
            <el-container style="width: 100%;">
                <el-header class="header">
                    <CommonHeader></CommonHeader>
                </el-header>
                <el-main class="main">
                    <CommonTag></CommonTag>
                    <router-view></router-view>
                </el-main>
            </el-container>
        </el-container>
    </div>
</template>


<script setup>
// 引入组件
// 头部组件
import CommonHeader from './components/CommonHeader.vue';
// 侧边栏组件
import CommonAside from './components/CommonAside.vue';
// 便签组件
import CommonTag from './components/CommonTag.vue';

</script>


<style lang="less" scoped>
.layout {
    .aside {
        width: auto;
        padding: 0;
        background: #545c64;
        overflow: hidden !important;
    }

    .header {
        padding: 0;
    }

    .main {
        padding: 20px;
        background: url(../assets/bg/k-on.png);
        background-size: 60%;
        background-repeat: no-repeat;
        background-position: 60% 85%;
        background-attachment: fixed;
    }
}
</style>
