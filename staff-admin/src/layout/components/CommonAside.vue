<template>
    <div class="CommonAside"
        :style="{ width: collapse ? 0.3299999909099099 + 'rem' : 1.197979061409448 + 'rem', borderRight: themeType ? '1px solid rgba(0, 0, 0, .3)' : '1px solid rgba(255, 255, 255, .3)' }">
        <el-menu :active-text-color="themeType ? '#f3a694' : '#30d5c8'" class="new-el-menu--sidebar"
            :default-active="defaultActive" :text-color="themeType ? '#333' : '#ebeaea'" :collapse="collapse"
            :popper-effect="themeType ? 'light' : 'dark'" router>
            <p v-show="!collapse" :style="{color: themeType ? 'rgba(0, 0, 0, 1)':'rgba(255, 255, 255, 1)'}">员工后台管理</p>

            <!-- 首页 -->
            <el-menu-item @click="clickMenu('/home', '首页')" index="/home" v-if="authorityList.indexOf('home') != -1">
                <el-icon>
                    <component :is="icons[0]"></component>
                </el-icon>
                <template #title>
                    <span class="fontSize17" >首页</span>
                </template>
            </el-menu-item>


            <!-- 员工管理 -->
            <el-sub-menu index="员工管理" :popper-class="themeType ?'bglightBlur':'bgdarkBlur'" v-if="authorityList.indexOf('staff') != -1">
                <template #title>
                    <el-icon>
                        <component :is="icons[1]"></component>
                    </el-icon>
                    <span class="fontSize17">员工管理</span>
                </template>
                <el-menu-item @click="clickMenu('/staffMsg', '员工管理|信息管理')" index="/staffMsg" v-if="authorityList.indexOf('staffMsg') != -1">
                    <span class="fontSize17">信息管理</span>
                </el-menu-item>
                <el-menu-item @click="clickMenu('/checkingIn', '员工管理|考勤管理')" index="/checkingIn" v-if="authorityList.indexOf('checkingIn') != -1">
                    <span class="fontSize17">考勤管理</span>
                </el-menu-item>
            </el-sub-menu>


            <!-- 通知管理 -->
            <el-sub-menu index="通知管理" :popper-class="themeType ?'bglightBlur':'bgdarkBlur'" v-if="authorityList.indexOf('notice') != -1">
                <template #title>
                    <el-icon>
                        <component :is="icons[2]"></component>
                    </el-icon>
                    <span class="fontSize17">通知管理</span>
                </template>
                <el-menu-item @click="clickMenu('/noticeRelease', '通知管理|发布通知')" index="/release" v-if="authorityList.indexOf('noticeRelease') != -1">
                    <span class="fontSize17">发布通知</span>
                </el-menu-item>
                <el-menu-item @click="clickMenu('/noticeHistory', '通知管理|历史记录')" index="/noticeHistory" v-if="authorityList.indexOf('noticeHistory') != -1">
                    <span class="fontSize17">历史记录</span>
                </el-menu-item>
            </el-sub-menu>

            
            <!-- 请假审核 -->
            <el-sub-menu index="请假审核" :popper-class="themeType ?'bglightBlur':'bgdarkBlur'" v-if="authorityList.indexOf('leave') != -1">
                <template #title>
                    <el-icon>
                        <component :is="icons[3]"></component>
                    </el-icon>
                    <span class="fontSize17">请假审核</span>
                </template>
                <el-menu-item @click="clickMenu('/leaveAudit', '请假审核|审核')" index="/leaveAudit" v-if="authorityList.indexOf('leaveAudit') != -1">
                    <span class="fontSize17"> 审核</span>
                </el-menu-item>
                <el-menu-item @click="clickMenu('/leaveHistory', '请假审核|历史记录')" index="/leaveHistory" v-if="authorityList.indexOf('leaveHistory') != -1">
                    <span class="fontSize17"> 历史记录</span>
                </el-menu-item>
            </el-sub-menu>


            <!-- 用户管理 -->
            <el-menu-item @click="clickMenu('/user', '用户管理')" index="/user" v-if="authorityList.indexOf('user') != -1">
                <el-icon>
                    <component :is="icons[4]"></component>
                </el-icon>
                <template #title>
                    <span class="fontSize17">用户管理</span>
                </template>
            </el-menu-item>


            <!-- 操作请求审核 -->
            <el-menu-item @click="clickMenu('/operatingRequestAudit', '操作请求审核')" index="/operatingRequestAudit" v-if="authorityList.indexOf('operatingRequestAudit') != -1">
                <el-icon>
                    <component :is="icons[5]"></component>
                </el-icon>
                <template #title>
                    <span class="fontSize17">操作请求审核</span>
                </template>
            </el-menu-item>


            <!-- 离职审核 -->
            <el-sub-menu index="离职审核" :popper-class="themeType ?'bglightBlur':'bgdarkBlur'" v-if="authorityList.indexOf('dimission') != -1">
                <template #title>
                    <el-icon>
                        <component :is="icons[6]"></component>
                    </el-icon>
                    <span class="fontSize17">离职审核</span>
                </template>
                <el-menu-item @click="clickMenu('/dimissionAudit', '离职审核|审核')" index="/dimissionAudit" v-if="authorityList.indexOf('dimissionAudit') != -1">
                    <span class="fontSize17">审核</span>
                </el-menu-item>
                <el-menu-item @click="clickMenu('/dimissionData', '离职审核|离职员工表')" index="/dimissionData" v-if="authorityList.indexOf('dimissionData') != -1">
                    <span class="fontSize17">离职员工表</span>
                </el-menu-item>
            </el-sub-menu>

            <!-- 操作记录 -->
            <el-menu-item @click="clickMenu('/operatingData', '操作记录')" index="/operatingData" v-if="authorityList.indexOf('operatingData') != -1">
                <el-icon>
                    <component :is="icons[8]"></component>
                </el-icon>
                <template #title>
                    <span class="fontSize17">操作记录</span>
                </template>
            </el-menu-item>

            <!-- 反馈消息 -->
            <el-menu-item @click="clickMenu('/feedback', '反馈消息')" index="/feedback" v-if="authorityList.indexOf('feedback') != -1">
                <el-icon>
                    <component :is="icons[7]"></component>
                </el-icon>
                <template #title>
                    <span class="fontSize17">反馈消息</span>
                </template>
            </el-menu-item>


        </el-menu>
    </div>
</template>


<script setup>
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入路由
import { useRoute, useRouter } from "vue-router"
// 引入vue
import { watch, ref, computed } from 'vue'
// 引入layout仓库
import { useLayoutStore } from '../../stores/layout'
// 引入layout仓库
import { useLoginStore } from '../../stores/login'


// 使用路由
const route = useRoute()
const router = useRouter()

// 默认的高亮
let defaultActive = ref("/home")

// 使用layout仓库
let layoutStore = useLayoutStore()

// layout仓库的state数据
const {
    // 主题
    theme,
    //显示或隐藏的状态
    collapse
} = storeToRefs(layoutStore)


// 使用login仓库
let loginStore = useLoginStore()

// login仓库的state数据
const {
    // 权限表
    authorityList,
} = storeToRefs(loginStore)

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

// layout仓库的action方法
const {
    //点击菜单事件的方法
    selectMenu
} = layoutStore

//监听路由的变化
watch(route, () => {
    defaultActive.value = route.path
}, { immediate: true })

//点击菜单事件
const clickMenu = (path, label) => {
    selectMenu(path, label)
    router.push({ path })
}

//图标
const icons = ["HomeFilled", "UserFilled", "BellFilled", "ColdDrink", "Avatar", "WarningFilled", "Failed", "Message", "Clock"]

</script>

<!-- elementPlus样式修改 -->
<style lang="less" scoped>
.el-menu {
    border: none;
    height: 100vh;

    p:nth-of-type(1) {
        padding: 30px 0px;
        font-size: 20px;
        text-align: center;
        color: white;
    }
}

.new-el-menu--sidebar:not(.el-menu--collapse) {
    width: 230px;
}

.el-menu--collapse {
    transition-duration: .9s;
}

:deep(.el-menu) {
    background: transparent !important;

    .fontSize17 {
        font-size: 17px;
    }
}

.el-menu-item:hover {
    background-color: rgba(64, 158, 255, .3);
}

:deep(.el-sub-menu__title):hover {
    background-color: rgba(64, 158, 255, .3);
}
</style>

<style lang="less">
.CommonAside {
    height: 100vh;
    backdrop-filter: blur(25px) !important;
    transition-duration: .7s;
    overflow-y: auto;
    overflow-x: hidden;
}

.bglightBlur {
    background: transparent !important;
    backdrop-filter: blur(20px);
    box-shadow: 0 0 5px 5px rgba(0, 0, 0, .2)!important;
    border: none !important;
    transition-duration: 0s;
    .el-menu {
        background: transparent;
        box-shadow: none!important;
        transition-duration: 0s;
        .el-menu-item {
            font-size: 15px !important;
            box-shadow: none!important;
            transition-duration: 0s;
        }
    }
}
.bgdarkBlur{
    background: transparent !important;
    backdrop-filter: blur(20px);
    box-shadow: 0 0 5px 5px rgba(255, 255, 255, .2)!important;
    border: none !important;
    transition-duration: 0s;
    .el-menu {
        background: transparent;
        box-shadow: none!important;
        transition-duration: 0s;
        .el-menu-item {
            font-size: 15px !important;
            box-shadow: none!important;
            transition-duration: 0s;
        }
    }
}
</style>

