<template>
    <div class="CommonAside" :style="{ width: collapse ? 0.3299999909099099 + 'rem' : 1.197979061409448 + 'rem' }">
        <el-menu active-text-color="#ffd04b" background-color="#545c64" class="new-el-menu--sidebar"
            :default-active="defaultActive" text-color="#fff" :collapse="collapse" popper-effect="light" router>
            <p v-show="!collapse">通用后台管理</p>

            <!-- 首页 -->
            <el-menu-item @click="clickMenu('/home', '首页')" index="/home">
                <el-icon>
                    <component :is="icons[0]"></component>
                </el-icon>
                <template #title>首页</template>
            </el-menu-item>


            <!-- 员工管理 -->
            <el-sub-menu index="员工管理">
                <template #title>
                    <el-icon>
                        <component :is="icons[1]"></component>
                    </el-icon>
                    <span>员工管理</span>
                </template>
                <el-menu-item @click="clickMenu('/message', '员工管理|信息管理')" index="/message">信息管理</el-menu-item>
                <el-menu-item @click="clickMenu('/checkingIn', '员工管理|考勤管理')" index="/checkingIn">考勤管理</el-menu-item>
            </el-sub-menu>

            <!-- 通知管理 -->
            <el-sub-menu index="通知管理">
                <template #title>
                    <el-icon>
                        <component :is="icons[2]"></component>
                    </el-icon>
                    <span>通知管理</span>
                </template>
                <el-menu-item @click="clickMenu('/release', '通知管理|发布通知')" index="/release">发布通知</el-menu-item>
                <el-menu-item @click="clickMenu('/informHistory', '通知管理|历史记录')" index="/informHistory">历史记录</el-menu-item>
            </el-sub-menu>

            <!-- 请假审核 -->
            <el-sub-menu index="请假审核">
                <template #title>
                    <el-icon>
                        <component :is="icons[3]"></component>
                    </el-icon>
                    <span>请假审核</span>
                </template>
                <el-menu-item @click="clickMenu('/leaveAudit', '请假审核|审核')" index="/leaveAudit">审核</el-menu-item>
                <el-menu-item @click="clickMenu('/leaveHistory', '请假审核|历史记录')" index="/leaveHistory">历史记录</el-menu-item>
            </el-sub-menu>

            <!-- 用户管理 -->
            <el-sub-menu index="用户管理">
                <template #title>
                    <el-icon>
                        <component :is="icons[3]"></component>
                    </el-icon>
                    <span>用户管理</span>
                </template>
                <el-menu-item @click="clickMenu('/userManage', '用户管理|用户信息')" index="/userManage">用户信息</el-menu-item>
                <el-menu-item @click="clickMenu('/authority', '用户管理|权限管理')" index="/authority">权限管理</el-menu-item>
            </el-sub-menu>

            <!-- 操作内容审核 -->
            <el-menu-item @click="clickMenu('/operatingAudit', '操作内容审核')" index="/operatingAudit">
                <el-icon>
                    <component :is="icons[5]"></component>
                </el-icon>
                <template #title>操作内容审核</template>
            </el-menu-item>


            <!-- 离职审核 -->
            <el-sub-menu index="离职审核">
                <template #title>
                    <el-icon>
                        <component :is="icons[6]"></component>
                    </el-icon>
                    <span>离职审核</span>
                </template>
                <el-menu-item @click="clickMenu('/dimissionAudit', '离职审核|审核')" index="/dimissionAudit">审核</el-menu-item>
                <el-menu-item @click="clickMenu('/dimissionData', '离职审核|离职员工表')" index="/dimissionData">离职员工表</el-menu-item>
            </el-sub-menu>

            <!-- 操作记录 -->
            <el-menu-item @click="clickMenu('/operatingData', '操作记录')" index="/operatingData">
                <el-icon>
                    <component :is="icons[8]"></component>
                </el-icon>
                <template #title>操作记录</template>
            </el-menu-item>

            <!-- 反馈消息 -->
            <el-menu-item @click="clickMenu('/feedback', '反馈消息')" index="/feedback">
                <el-icon>
                    <component :is="icons[7]"></component>
                </el-icon>
                <template #title>反馈消息</template>
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
import { watch, ref } from 'vue'
// 引入layout仓库
import { useLayoutStore } from '../../stores/layout'


// 使用路由
const route = useRoute()
const router = useRouter()

// 默认的高亮
let defaultActive = ref("/home")

// 使用layout仓库
const layoutStore = useLayoutStore()

// layout仓库的state数据
const {
    //显示或隐藏的状态
    collapse
} = storeToRefs(layoutStore)

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
const icons = ["HomeFilled", "UserFilled", "BellFilled", "ColdDrink", "Key", "WarningFilled", "Failed", "Message", "Clock"]

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
</style>

<style lang="less" scoped>
.CommonAside {
    height: 100vh;
    transition-duration: .7s;
    overflow-y: auto;
    overflow-x: hidden;


}
</style>

