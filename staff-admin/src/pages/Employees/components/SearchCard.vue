<template>
    <Card class="search" title="查询条件" :theme="theme" :class="[theme === 'light' ? 'light' : 'dark']">
        <template v-slot:body>
            <el-form :model="form" label-width="27%">
                <el-row :gutter="15">
                    <el-col :span="6">
                        <el-form-item label="部门名称:">
                            <el-select clearable v-model="form.departId" :disabled="!hasAllStaffMsgView" placeholder="请选择部门"
                                size="large">
                                <el-option v-for="i in departmentList" :key="i.departId" :label="i.department_Name"
                                    :value="i.departId" />
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="进入公司时间:">
                            <el-date-picker v-model="form.entryTime" type="daterange" range-separator="——"
                                start-placeholder="开始时间" end-placeholder="结束时间" value-format="YYYY-MM-DD"
                                :unlink-panels="true" size="large" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="职位类型:">
                            <el-select clearable v-model="form.job" placeholder="请选择职位" size="large">
                                <el-option v-for="(i, index) in jobType" :key="index" :label="i" :value="i" />
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="性别:">
                            <el-select clearable v-model="form.sex" placeholder="请选择性别" size="large">
                                <el-option label="男" value="男" />
                                <el-option label="女" value="女" />
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="薪资范围:">
                            <div class="numRange" style="width: 90%;">
                                <div class="left">
                                    <el-input-number v-model="form.startSalary" :precision="1" :step="0.1" :min="0"
                                        :max="999" size="large" controls-position="right" />
                                    <span class="k">K</span>
                                </div>
                                <span>——</span>
                                <div class="right">
                                    <el-input-number v-model="form.endSalary" :precision="1" :step="0.1" :min="0" :max="999"
                                        size="large" controls-position="right" />
                                    <span class="k">K</span>
                                </div>

                            </div>
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="员工年龄范围:">
                            <div class="numRange" style="width: 100%;">
                                <div class="left">
                                    <el-input-number v-model="form.startAge" :precision="0" :step="1" :min="0" :max="999"
                                        size="large" controls-position="right" />
                                </div>
                                <span>——</span>
                                <div class="right">
                                    <el-input-number v-model="form.endAge" :precision="0" :step="1" :min="0" :max="999"
                                        size="large" controls-position="right" />
                                </div>
                            </div>
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="关键字:">
                            <el-input style="width: 90%;" v-model="form.searchValue" size="large" placeholder="请输入搜索的姓名" class="input"
                                :suffix-icon="Search" clearable />
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
import { onMounted, computed, reactive, onBeforeUnmount } from "vue"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'
// 引入employees仓库
import { useEmployeesStore } from '../../../stores/employees'
//搜索
import { Search } from '@element-plus/icons-vue'


// 获取layout仓库
let layoutStore = useLayoutStore()

// 获取login仓库
let loginStore = useLoginStore()

// 获取employees仓库
let employeesStore = useEmployeesStore()

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// login仓库的state数据
const {
    //权限列表
    authorityList,
    //部门id
    departId
} = storeToRefs(loginStore)

// employees仓库的action方法
const {
    //获取部门信息
    getDepartmentList,
    //获取职位类型
    getJobType,
    //筛选员工信息
    filterStaffData
} = employeesStore

// employees仓库的state数据
const {
    // 部门列表
    departmentList,
    // 职位类型
    jobType,
    // 员工信息搜索信息表单
    employeesSearchForm,
} = storeToRefs(employeesStore)

const form = reactive({
    departId: "",
    entryTime: "",
    job: "",
    sex: "",
    startSalary: 0,
    endSalary: 0,
    startAge: 0,
    endAge: 0,
    searchValue: ""
})

//筛选员工
const handleFilter = async () => {
    if (!form.entryTime) {
        form.entryTime = ["", ""]
    }
    employeesSearchForm.value = {
        ...employeesSearchForm.value, ...{
            departId: form.departId,
            startEntryTime: form.entryTime[0],
            endEntryTime: form.entryTime[1],
            job: form.job,
            sex: form.sex,
            startSalary: form.startSalary * 1000,
            endSalary: form.endSalary * 1000,
            startAge: form.startAge,
            endAge: form.endAge,
            searchValue: form.searchValue
        }
    }
    await filterStaffData(employeesSearchForm.value)
}

//是否有查看所有员工信息的权力
const hasAllStaffMsgView = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "allStaffMsgView"
    })
    if (index === -1) {
        form.departId = departId.value
    }
    return index !== -1
})

// 清除搜索内容
const handleClearCard = async () => {
    if (hasAllStaffMsgView.value) {
        form.departId = ""
        form.entryTime = ""
        form.job = ""
        form.sex = ""
        form.startSalary = 0
        form.endSalary = 0
        form.startAge = 0
        form.endAge = 0
        form.searchValue = ""
        employeesSearchForm.value = {
            ...employeesSearchForm.value, ...{
                departId: "",
                startEntryTime: "",
                endEntryTime: "",
                job: "",
                sex: "",
                startSalary: 0,
                endSalary: 0,
                startAge: 0,
                endAge: 0,
                searchValue: ""
            }
        }
    } else {
        form.departId = departId.value
        form.entryTime = ""
        form.job = ""
        form.sex = ""
        form.startSalary = 0
        form.endSalary = 0
        form.startAge = 0
        form.endAge = 0
        form.searchValue = ""
        employeesSearchForm.value = {
            ...employeesSearchForm.value, ...{
                departId: departId.value,
                startEntryTime: "",
                endEntryTime: "",
                job: "",
                sex: "",
                startSalary: 0,
                endSalary: 0,
                startAge: 0,
                endAge: 0,
                searchValue: ""
            }
        }
    }

    await filterStaffData(employeesSearchForm.value)
}

//获取数据
const getData = async () => {
    //获取部门列表
    await getDepartmentList()
    //获取公司职位类型
    await getJobType()
}

onMounted(async () => {
    await getData()
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
    margin-bottom: 24.5px;

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
        justify-content: flex-end;

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


