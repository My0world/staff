<template>
    <Card class="search" title="查询条件" :theme="theme" :class="[theme === 'light' ? 'light' : 'dark']">
        <template v-slot:body>
            <el-form :model="form" label-width="27%">
                <el-row :gutter="15">
                    <el-col :span="6">
                        <el-form-item label="用户状态:">
                            <el-select clearable v-model="form.status" placeholder="请选择用户状态" size="large">
                                <el-option label="在线" value="在线" />
                                <el-option label="下线" value="下线" />
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="部门:">
                            <el-select clearable v-model="form.departId" placeholder="请选择部门" size="large">
                                <el-option v-for="i in departmentList" :key="i.departId" :label="i.department_Name"
                                    :value="i.departId" />
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <div class="btn_group">
                            <el-button size="large" @click="handleClearCard">清除</el-button>
                            <el-button type="primary" size="large" @click="handleFilter">查询</el-button>
                        </div>
                    </el-col>
                </el-row>
            </el-form>
        </template>
    </Card>
</template>


<script setup>
import { onMounted, computed, reactive, onBeforeUnmount, ref } from "vue"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入employees仓库
import { useEmployeesStore } from '../../../stores/employees'
// 引入user仓库
import { useUserStore } from '../../../stores/user'
//搜索
import { Search } from '@element-plus/icons-vue'

// 使用user仓库
let userStore = useUserStore()

// 获取layout仓库
let layoutStore = useLayoutStore()

// 获取employees仓库
let employeesStore = useEmployeesStore()

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// employees仓库的action方法
const {
    //获取部门信息
    getDepartmentList,
} = employeesStore

// employees仓库的state数据
const {
    // 部门列表
    departmentList,
} = storeToRefs(employeesStore)

// user仓库的action方法
const {
    //筛选用户信息
    filterUserData
} = userStore

// user仓库的state数据
const {
    // 用户信息搜索信息表单
    userForm,
} = storeToRefs(userStore)

//等待动画
let loadingInstance = ref(null)

// 筛选表单
const form = reactive({
    status: "",
    departId: ""
})

// 清除搜索
const handleClearCard = async () => {
    form.status = ""
    form.departId = ""
    userForm.value = {
        ...userForm.value, ...{
            status: "",
            departId: "",
            pageNo:1
        }
    }
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterUserData(userForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

// 对数据筛选
const handleFilter = async () => {
    userForm.value = {
        ...userForm.value, ...{
            status: form.status,
            departId: form.departId,
            pageNo:1
        }
    }
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterUserData(userForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//获取数据
const getData = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    //获取部门列表
    await getDepartmentList().then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

onMounted(async () => {
    getData()
})

onBeforeUnmount(() => {
    handleClearCard()
})



</script>


<style scoped lang="less">
:deep(.el-form-item__label) {
    height: 40px !important;
    justify-content: center;
    align-items: center;
}

:deep(.el-select--large) {
    width: 90%;
}


:deep(.el-button) {
    height: 40px;
    line-height: 40px;
    margin-right: 35px;
}

:deep(.el-divider--horizontal) {
    margin: 0px 0px 0.09375rem 0px;
}
</style>


<style scoped lang="less">
.search {
    margin-bottom: 14.5px;

    .numRange {

        border-radius: 4px;
        height: 40px;
        background: #fff;
        display: flex;
        justify-content: space-between;
        align-items: center;
        overflow: hidden;

        .left {
            position: relative;

            :deep(.el-input-number--large):nth-of-type(1) {
                width: 100px;


                .el-input__wrapper {
                    padding-right: 15px;
                    padding-left: 42px;
                    box-shadow: none !important;
                }

                .el-input-number__decrease {
                    right: unset;
                    left: 0;
                    border-right: 1px solid #dcdfe6;
                    border-radius: 0 !important;
                }

                .el-input-number__increase {
                    right: unset;
                    left: 0;
                    border-right: 1px solid #dcdfe6;
                    border-radius: 0 !important;
                }
            }

            .k {
                color: #606266;
                position: absolute;
                top: 0;
                right: 5px;
                width: 15px;
                height: 100%;
                line-height: 35.55px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
        }

        .right {
            position: relative;

            :deep(.el-input-number--large):nth-of-type(1) {
                width: 100px;


                .el-input__wrapper {
                    box-shadow: none !important;
                    padding-left: 0;
                    padding-right: 57px;
                }

                .el-input__inner {
                    width: 38.24px;

                }


                .el-input-number__decrease {
                    right: 0;
                    left: unset;
                    border-radius: 0 !important;
                }

                .el-input-number__increase {
                    right: 0;
                    left: unset;
                    border-radius: 0 !important;
                }
            }

            .k {
                color: #606266;
                position: absolute;
                top: 0;
                right: 45px;
                width: 15px;
                height: 100%;
                line-height: 35.55px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
        }
    }

    .btn_group {
        display: flex;
        justify-content: flex-start;

        :deep(.el-button):nth-of-type(1) {
            margin-right: 0px;
        }
    }

    .input {
        width: 363px;
    }
}

.light {
    :deep(.el-form-item__label) {
        color: #333333 !important;
    }
}

.dark {
    :deep(.el-form-item__label) {
        color: #EBEAEA !important;
    }
}
</style>
