<template>
    <div class="container"
        :style="{ borderBottom: themeType ? '1px solid rgba(0, 0, 0, .3)' : '1px solid rgba(255, 255, 255, .3)' }">
        <!-- 面包屑和侧边栏的显示/隐藏按钮 -->
        <div class="l-content">
            <el-button style="margin-right: 10px;" @click="setCollapse" size="small" type="primary" icon="Menu" />
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><span
                        :style="{ color: themeType ? 'rgba(0, 0, 0, 1)' : 'rgba(255, 255, 255, 1)' }">首页</span></el-breadcrumb-item>
                <el-breadcrumb-item v-for="(i, index) in currentMenu" :key="index"><span
                        :style="{ color: themeType ? '#f3a694' : '#30d5c8' }">{{ i }}</span></el-breadcrumb-item>
            </el-breadcrumb>

        </div>
        <!-- 头像 -->
        <div class="r-content">
            <ThemeSwitch></ThemeSwitch>
            <el-dropdown>
                <el-image class="iconImg" :src="userIcon('user', 'jpg')" fit="contain" />
                <template #dropdown>
                    <el-dropdown-menu>
                        <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
                    </el-dropdown-menu>
                </template>
            </el-dropdown>

        </div>
    </div>
</template>


<script setup>

import { computed, getCurrentInstance,ref } from "vue";
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 图片处理
import imageSrc from "../../util/imageSrc"
// 引入layout仓库
import { useLayoutStore } from '../../stores/layout'
// 引入login仓库
import { useLoginStore } from '../../stores/login'
// 引入路由
import { useRouter } from "vue-router"

//使用路由
let router = useRouter()

//获取全局挂载
let internalInstance = getCurrentInstance();

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

// 使用layout仓库
let layoutStore = useLayoutStore()

// 使用login仓库
let loginStore = useLoginStore()

//等待动画
let loadingInstance = ref(null)

const {
    // 主题
    theme,
    // 当前路径
    currentMenu,
} = storeToRefs(layoutStore)

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

// layout仓库的action方法
const {
    //点击菜单事件的方法
    setCollapse
} = layoutStore

// login仓库的action方法
const {
    // 退出登录
    setLogoutStatus,
} = loginStore

// 图片处理（函数）
let userIcon = imageSrc

// 退出登录
const logout = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await setLogoutStatus().then((result) => {
        //动画结束
        loadingInstance.value.close()
        $ElMessage({
            message: result,
            type: "success"
        })
        router.push({ path: "/login" })
    }).catch((err) => {
        //动画结束
        loadingInstance.value.close()
    });
    

}

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
        font-size: 17px;
    }
}
</style>


<style lang="less" scoped>
.container {
    width: 100%;
    height: 60px;
    backdrop-filter: blur(25px);
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
        user-select: none;
        display: flex;
        align-items: center;
        margin-right: 20px;

        .iconImg {
            margin-left: 20px;
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: 2px solid white;
            cursor: pointer;
        }
    }
}
</style>
