<template>
    <Card class="search" title="查询条件" :theme="theme" :class="[theme === 'light' ? 'light' : 'dark']">
        <template v-slot:body>
            <el-form :model="form" label-width="27%">
                <el-row :gutter="15">
                    <el-col :span="6">
                        <el-form-item label="员工离职时间:">
                            <el-date-picker v-model="form.resignTime" type="daterange" range-separator="——"
                                start-placeholder="开始时间" end-placeholder="结束时间" value-format="YYYY-MM-DD"
                                :unlink-panels="true" size="large" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="部门名称:">
                            <el-select clearable v-model="form.departId" placeholder="请选择部门" size="large">
                                <el-option v-for="i in departmentList" :key="i.departId" :label="i.department_Name"
                                    :value="i.departId" />
                            </el-select>
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
                        <el-form-item label="员工年龄范围:">
                            <div class="numRange" style="width: 100%;">
                                <div class="left">
                                    <el-input-number v-model="form.startAge" :precision="0" :step="1" :min="0"
                                        :max="999" size="large" controls-position="right" />
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
                            <el-input style="width: 90%;" v-model="form.searchValue" size="large" placeholder="请输入搜索的姓名"
                                class="input" :suffix-icon="Search" clearable />
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
// 引入dimission仓库
import { useDimissionStore } from '../../../stores/dimission'
//搜索
import { Search } from '@element-plus/icons-vue'

// 获取layout仓库
let layoutStore = useLayoutStore()

// 获取employees仓库
let employeesStore = useEmployeesStore()

// 获取dimission仓库
let dimissionStore = useDimissionStore()

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// employees仓库的action方法
const {
    //获取部门信息
    getDepartmentList,
    //获取职位类型
    getJobType,
} = employeesStore

// employees仓库的action方法
const {
    //获取离职员工数据
    filterDimissionListData,
} = dimissionStore

// employees仓库的state数据
const {
    // 部门列表
    departmentList,
    // 职位类型
    jobType,
} = storeToRefs(employeesStore)

 
// employees仓库的state数据
const {
    // 职位类型
    dimissionSearchForm,
} = storeToRefs(dimissionStore)


//等待动画
let loadingInstance = ref(null)

// 筛选表单
const form = reactive({
    resignTime: "",
    departId: "",
    job: "",
    sex: "",
    startAge: 0,
    endAge: 0,
    searchValue: ""
})

//筛选员工
const handleFilter = async () => {
    if (!form.resignTime) {
        form.resignTime = ["", ""]
    }
    dimissionSearchForm.value = {
        ...dimissionSearchForm.value, ...{
            departId: form.departId,
            startResignTime: form.resignTime[0],
            endResignTime: form.resignTime[1],
            job: form.job,
            sex: form.sex,
            startAge: form.startAge,
            endAge: form.endAge,
            searchValue: form.searchValue
        }
    }
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterDimissionListData(dimissionSearchForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

// 清除搜索内容
const handleClearCard = async () => {
    form.departId = ""
    form.resignTime = ""
    form.job = ""
    form.sex = ""
    form.startAge = 0
    form.endAge = 0
    form.searchValue = ""
    dimissionSearchForm.value = {
        ...dimissionSearchForm.value, ...{
            departId: "",
            startResignTime: "",
            endResignTime: "",
            job: "",
            sex: "",
            startAge: 0,
            endAge: 0,
            searchValue: ""
        }
    }

    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterDimissionListData(dimissionSearchForm.value).then((resolve) => {
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
    //获取部门列表,获取公司职位类型
    Promise.all([getDepartmentList(), getJobType()]).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

onMounted(async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await getData().then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
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
        padding-left: 15px;

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
