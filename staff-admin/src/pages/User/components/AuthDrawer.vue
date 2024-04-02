<template>
    <div class="treeContainer">
        <el-tree ref="treeRef" style="max-width: 600px" :data="formatterAuthorityData" show-checkbox default-expand-all
            node-key="id" highlight-current :props="defaultProps" />
    </div>
    <div class="treeFooter">

    </div>

</template>


<script setup>
import { onMounted, ref, watch } from 'vue';
// 引入user仓库
import { useUserStore } from '../../../stores/user'
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 获取user仓库
let userStore = useUserStore()

let props = defineProps(["auth"])


// 树形数据ref
let treeRef = ref(null)

// login仓库的action方法
const {
    // 获取权限信息
    getAuthorityData,
} = userStore

// login仓库的state数据
const {
    //权限列表
    formatterAuthorityData,
    //原始权限列表
    allAuthorityList,
} = storeToRefs(userStore)

//获取选择的权限
const getCheckedAuthData = () => {
    console.log(treeRef.value.getCheckedNodes(false));
}

//树形图props
const defaultProps = {
    children: 'children',
    label: 'description',
}

//监听props
// watch(props, () => {
//     let list = []
//     props.auth.split(",").forEach(item => {
//         let index = allAuthorityList.value.findIndex(citem => {
//             console.log(citem);
//             return item === citem.right_name
//         })
//         // list.push(AuthItem.id)

//         // treeRef.value.setCheckedKeys(list,true)
//     });
// }, { immediate: true })

//获取权限树
const getData = async () => {
    await getAuthorityData()
}

onMounted(() => {
    getData()
})

</script>


<style scoped lang="less">
:deep(.el-tree) {
    .el-tree-node__label {
        font-size: 16px
    }
}
</style>
