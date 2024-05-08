<template>
    <div class="borderCard">
        <p style="margin-bottom: 10px;">
            <span :style="{color:theme === 'light' ? '#000' : '#fff'}">用户名：</span>
            <span :style="{color:theme === 'light' ? '#000' : '#fff'}">{{ staffName }}</span>
        </p>
        <p>
            <span :style="{color:theme === 'light' ? '#000' : '#fff'}">部门：</span>
            <span :style="{color:theme === 'light' ? '#000' : '#fff'}">{{ departmentName }}</span>
        </p>
    </div>
</template>


<script setup>
import { computed, onMounted, ref } from 'vue';
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'
// 引入employees仓库
import { useEmployeesStore } from '../../../stores/employees'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'




// 获取login仓库
let loginStore = useLoginStore()
// 获取employees仓库
let employeesStore = useEmployeesStore()
// 获取layout仓库
let layoutStore = useLayoutStore()


//等待动画
let loadingInstance = ref(null)

// layout仓库的state数据
const {
    // 主题
    theme
} = storeToRefs(layoutStore)


// login仓库的state数据
const {
    //用户名
    staffName,
    //部门ID
    departId
} = storeToRefs(loginStore)

// employees仓库的state数据
const {
    // 部门列表
    departmentList,
} = storeToRefs(employeesStore)

// employees仓库的action方法
const {
    //获取部门信息
    getDepartmentList,
} = employeesStore

const departmentName = computed(() => {
    let i = departmentList.value.find(item => {
        return item.departId === departId.value
    })
    return i ? i.department_Name : ""
})



onMounted(async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await getDepartmentList().then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
})
</script>


<style>
.borderCard {
    border: 1px solid #eee;
    border-radius: 5px;
    padding: 14px;
    backdrop-filter: blur(100px);
}
</style>
