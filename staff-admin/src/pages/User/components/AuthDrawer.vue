<template>
    <div class="treeContainer">
        <el-tree ref="treeRef" style="max-width: 600px" :data="formatterAuthorityData" show-checkbox default-expand-all
            node-key="id" highlight-current :props="defaultProps" />
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

// user仓库的action方法
const {
    //获取权限树
    getAuthorityData
} = userStore

// user仓库的state数据
const {
    //权限列表
    formatterAuthorityData,
    //原始权限列表
    allAuthorityList,
} = storeToRefs(userStore)




//获取选择的权限
const getCheckedAuthData = () => {
    return [...treeRef.value.getHalfCheckedNodes(true), ...treeRef.value.getCheckedNodes(false)];
}

//树形图props
const defaultProps = {
    children: 'children',
    label: 'description',
}

//取子节点
const getAuthsChildren = (treeData, leafList) => {
    // 判断是否为数组
    if (Array.isArray(treeData)) {
        treeData.forEach(item => {
            if (item.children && item.children.length > 0) {
                getAuthsChildren(item.children, leafList)
            } else {
                leafList.push(item)
            }
        })
    } else {
        if (treeData.children && treeData.children.length > 0) {
            getAuthsChildren(treeData.children, leafList)
        } else {
            leafList.push(treeData)
        }
    }
}


//标记已有的权限
const setCheckAuth = async () => {
    //获取已有的权限
    let myAuths = []
    props.auth.split(",").forEach(item => {
        let index = allAuthorityList.value.findIndex(citem => {
            return item === citem.right_name
        })
        //首页必选
        if (allAuthorityList.value[index].right_name === "home") {
            console.log(allAuthorityList.value[index]);
            allAuthorityList.value[index].disabled = true
        }
        myAuths.push(allAuthorityList.value[index])
    });

    //生成权限树
    let myAuthsTree = []
    myAuths.forEach((item) => {
        //一级
        if (!item.two_level_name) {
            myAuthsTree.push({ ...item, children: [] })
            return
        }
    })
    myAuths.forEach((item) => {
        //一级
        if (!item.two_level_name) {
            return
        }
        //二级
        if (item.one_level_name && !item.three_level_name) {
            let twoIndex = myAuthsTree.findIndex(citem => {
                return citem.right_name == item.one_level_name
            })
            if (twoIndex !== -1) {
                myAuthsTree[twoIndex].children.push({ ...item, children: [] })
                return
            }
        }
    })
    myAuths.forEach((item) => {
        //一级
        if (!item.two_level_name) {
            return
        }
        //二级
        if (item.one_level_name && !item.three_level_name) {
            return
        }
        //三级
        if (item.three_level_name) {
            let twoIndex = myAuthsTree.findIndex(citem => {
                return citem.right_name == item.one_level_name
            })
            if (twoIndex !== -1) {
                let threeIndex = myAuthsTree[twoIndex].children.findIndex(citem => {
                    return citem.right_name == item.two_level_name
                })
                if (threeIndex !== -1) {
                    myAuthsTree[twoIndex].children[threeIndex].children.push({ ...item })
                    return
                }
            }
        }
    })
    //获取子节点
    let leafList = []
    getAuthsChildren(myAuthsTree, leafList)

    //获取子节点ID
    let leafListKeys = []
    leafList.forEach(item => {
        leafListKeys.push(item.id)
    })

    treeRef.value.setCheckedKeys(leafListKeys)
}

onMounted(async () => {
    await getAuthorityData().then(() => {
        setCheckAuth()
    })

})

defineExpose({
    getCheckedAuthData
})

</script>


<style scoped lang="less">
:deep(.el-tree) {
    .el-tree-node__label {
        font-size: 16px
    }
}
</style>
