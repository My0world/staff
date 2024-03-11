<template>
    <div class="CommonTag">
        <el-tag v-for="(tag, index) in tagList" :key="tag.path" :effect="tag.path === route.path ? 'dark' : 'light'"
            :closable="tag.path !== '/home' ? true : false" @click="clickTag(tag.path, tag.label)" @click.middle="handleClose(tag.path, index)"
            :disable-transitions="true" @close="handleClose(tag.path, index)">
            {{ tag.label }}
        </el-tag>
    </div>
</template>


<script setup>
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../stores/layout'
// 引入路由
import { useRoute, useRouter } from "vue-router"

// 使用路由
const route = useRoute()
const router = useRouter()

// 使用仓库
const layoutStore = useLayoutStore()

// layout仓库的state数据
const {
    //标签列表
    tagList
} = storeToRefs(layoutStore)

// layout仓库的action方法
const {
    //切换路径事件的方法
    selectMenu,
    //删除标签事件的方法
    deleteTag
} = layoutStore

//点击标签事件
const clickTag = (path, label) => {
    selectMenu(path, label)
    router.push({ path })
}

//删除标签
const handleClose = (path, index) => {
    if (route.path === path) {
        router.push({ path: tagList.value[index - 1].path })
        selectMenu(tagList.value[index - 1].path, tagList.value[index - 1].label)
        deleteTag(path)
        return
    }
    deleteTag(path)
}



</script>


<style lang="less" scoped>
.el-tag {
    margin-right: 7px;
    margin-bottom: 7px;
}

::v-deep(.el-tag__content) {
    font-size: 12px;
}
</style>

