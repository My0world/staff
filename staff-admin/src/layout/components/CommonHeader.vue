<template>
    <div class="container">
        <!-- 面包屑和侧边栏的显示/隐藏按钮 -->
        <div class="l-content">
            <el-button style="margin-right: 10px;" @click="setCollapse" size="small" type="primary" icon="Menu" />
            <el-breadcrumb separator="/">
                <el-breadcrumb-item>首页</el-breadcrumb-item>
                <el-breadcrumb-item  v-for="(i,index) in currentMenu" :key="index">{{ i }}</el-breadcrumb-item>
            </el-breadcrumb>

        </div>
        <!-- 头像 -->
        <div class="r-content">
            <el-dropdown>
                <el-image class="iconImg" :src="userIcon('user', 'jpg')" fit="contain" />
                <template #dropdown>
                    <el-dropdown-menu>
                        <el-dropdown-item @click="logout">退出</el-dropdown-item>
                    </el-dropdown-menu>
                </template>
            </el-dropdown>
        </div>
    </div>
</template>


<script setup>
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 图片处理
import imageSrc from "../../util/imageSrc"
// 引入layout仓库
import { useLayoutStore } from '../../stores/layout'


// 使用layout仓库
const layoutStore = useLayoutStore()

const { 
    // 当前路径
    currentMenu 
} = storeToRefs(layoutStore)

// layout仓库的action方法
const {
    //点击菜单事件的方法
    setCollapse
} = layoutStore




// 图片处理（函数）
const userIcon = imageSrc

</script>

<!-- elementPlus样式修改 -->
<style lang="less" scoped>
// 面包屑
::v-deep(.el-breadcrumb__item):nth-of-type(1) {
    .el-breadcrumb__inner {
        color: white !important;
    }
}

::v-deep(.el-breadcrumb__item) {
    .el-breadcrumb__inner {
        color: rgb(0, 183, 255) !important;
    }
}
</style>


<style lang="less" scoped>
.container {
    width: 100%;
    height: 60px;
    background: #333;
    display: flex;
    justify-content: space-between;
    align-items: center;

    // 面包屑和侧边栏的显示/隐藏按钮
    .l-content {
        margin-left: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    // 头像
    .r-content {
        margin-right: 20px;

        .iconImg {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: 2px solid white;
            cursor: pointer;
        }
    }
}
</style>

