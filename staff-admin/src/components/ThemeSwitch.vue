<template>
    <el-switch class="ThemeSwitch" size="large" style="--el-switch-on-color: #ebeaea; --el-switch-off-color: #333"
        :active-action-icon="Sunny" v-model="themeType" :inactive-action-icon="Moon" @change="switchChange" />
</template>


<script setup>
//elementUI图标
import { Sunny, Moon } from '@element-plus/icons-vue'
// 引入vue
import { ref, watch } from 'vue'
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../stores/layout'
// 使用layout仓库
const layoutStore = useLayoutStore()

// layout仓库的action方法
const {
    //点击菜单事件的方法
    setTheme
} = layoutStore

// layout仓库的state数据
const {
    //显示或隐藏的状态
    theme
} = storeToRefs(layoutStore)

let themeType = ref(null)

// switch绑定的值
watch(theme, () => {
    themeType.value = theme.value === "light"
},{immediate:true})

//主题的改变事件
const switchChange = (v) => {
    setTheme()
}




</script>


<style scoped lang="less">
.ThemeSwitch {
    height: 21.33px;

    :deep(.el-switch__action) {
        color: black !important;
    }
}
</style>

