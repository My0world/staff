<template>
    <Card class="search" title="人员信息表" :theme="theme">
        <template v-slot:body>
            <div class="StaffMsgTable" :class="[theme === 'light' ? 'light' : 'dark']">
                <div class="operation">
                    <el-button type="primary" size="large" @click="handleAdd('添加')"
                        v-if="hasUserAddStaff">添加(需审核)</el-button>
                    <el-button type="primary" size="large" @click="handleAdd('添加')"
                        v-if="hasAdminAddStaff">添加</el-button>
                    <el-button type="primary" size="large" disabled
                        v-if="!hasAdminAddStaff && !hasUserAddStaff">添加</el-button>
                    <el-button link type="primary" size="large">您有新的内容可刷新</el-button>
                </div>
                <el-table :data="staffList" style="width: 100%;margin: 17px 0px;" border>
                    <el-table-column :resizable="false" prop="staffId" label="员工ID" min-width="35" />
                    <el-table-column :resizable="false" prop="departName" label="部门名称" min-width="45" />
                    <el-table-column :resizable="false" prop="staffName" label="姓名" min-width="50" />
                    <el-table-column :resizable="false" prop="phoneNum" label="电话号码" min-width="50" />
                    <el-table-column :resizable="false" prop="sex" label="性别" min-width="35" />
                    <el-table-column :resizable="false" prop="age" label="年龄" min-width="35" />
                    <el-table-column :resizable="false" prop="salary" label="薪资" min-width="45" />
                    <el-table-column :resizable="false" prop="job" label="职位" min-width="45" />
                    <el-table-column :resizable="false" prop="entryTime" label="入职时间" min-width="50">
                        <template #default="scope">
                            <span>
                                {{ GMTToStr(scope.row.entryTime) }}
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" fixed="right" label="操作栏"
                        v-if="hasUserUpdateStaff || hasAdminUpdateStaff || hasSettingDimission">

                        <template #default="scope">
                            <el-button v-if="hasUserUpdateStaff" size="small" @click="handleUpdate('修改', scope.row)"
                                type="warning">修改(需审核)</el-button>
                            <el-button v-if="hasAdminUpdateStaff" size="small" @click="handleUpdate('修改', scope.row)"
                                type="warning">修改</el-button>
                            <el-button v-if="hasSettingDimission" size="small" @click="handleResign(scope.row)"
                                type="danger">设置为离职状态</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-model:current-page="employeesSearchForm.pageNo"
                    v-model:page-size="employeesSearchForm.pageSize" :page-sizes="[5, 8, 15, 30]"
                    layout=" jumper, total,->, prev, pager, next,sizes," :total="total" :background="true"
                    @current-change="handleCurrentChange" @size-change="handleSizeChange" />
            </div>
        </template>
    </Card>
    <StaffMsgDialog ref="StaffMsgDialogRef"></StaffMsgDialog>
</template>


<script setup>
import { ref, computed, onMounted, getCurrentInstance } from 'vue';
//添加和修改对话框
import StaffMsgDialog from "./StaffMsgDialog.vue"
//API
import employees from '../../../api'
// 格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入employees仓库
import { useEmployeesStore } from '../../../stores/employees'

//获取全局挂载
let internalInstance = getCurrentInstance();

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

// 使用login仓库
let loginStore = useLoginStore()

// 使用layout仓库
let layoutStore = useLayoutStore()

// 使用employees仓库
let employeesStore = useEmployeesStore()

//等待动画
let loadingInstance = ref(null)

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// employees仓库的state数据
const {
    //员工信息
    staffList,
    //员工总数
    total,
    // 员工信息搜索信息表单
    employeesSearchForm
} = storeToRefs(employeesStore)

//login仓库的state数据
const {
    // 权限列表
    authorityList,
    // 员工id
    departId,
} = storeToRefs(loginStore)

// employees仓库的action方法
const {
    //筛选员工信息
    filterStaffData,
} = employeesStore


// 是否有设置员工为离职的权限
const hasSettingDimission = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "settingDimission"
    })
    return index !== -1
})

// 是否有添加员工权限（无需审核）
const hasAdminAddStaff = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "adminAddStaff"
    })
    return index !== -1
})

// 是否有添加员工权限（需审核）
const hasUserAddStaff = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "userAddStaff"
    })
    return index !== -1
})

// 是否有修改员工权限（无需审核）
const hasAdminUpdateStaff = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "adminUpdateStaff"
    })
    return index !== -1
})

// 是否有修改员工权限（需审核）
const hasUserUpdateStaff = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "userUpdateStaff"
    })
    return index !== -1
})

//是否有查看所有员工信息的权力
const hasAllStaffMsgView = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "allStaffMsgView"
    })
    return index !== -1
})

//员工信息对话框
let StaffMsgDialogRef = ref(null)

//添加员工信息
const handleAdd = (tit) => {
    StaffMsgDialogRef.value.StaffMsgDialogShow(tit)
}

//修改员工信息
const handleUpdate = (tit, item) => {
    StaffMsgDialogRef.value.StaffMsgDialogShow(tit, item)
}

// 设置为离职员工
const handleResign = async (item) => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await employees.reqResignStaff({ ...item, entryTime: GMTToStr(item.entryTime) }).then(async resolve => {
        if (staffList.value.length === 1) {
            employeesSearchForm.value.pageNo = employeesSearchForm.value.pageNo - 1
            if (employeesSearchForm.value.pageNo === 0) {
                employeesSearchForm.value.pageNo = 1
            }
        }

        await getData()
        //动画结束
        loadingInstance.value.close()
        $ElMessage({
            message: resolve.message,
            type: "success"
        })
    }, reject => {
        //动画结束
        loadingInstance.value.close()
        $ElMessage({
            message: reject.message,
            type: "error"
        })
    })
}



//获取数据
const getData = async () => {

    if (!hasAllStaffMsgView.value) {
        employeesSearchForm.value.departId = departId.value
    } else {
        employeesSearchForm.value.departId = ""
    }
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterStaffData(employeesSearchForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//页码变化
const handleCurrentChange = async (pageNo) => {
    employeesSearchForm.value.pageNo = pageNo
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await getData().then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//当前页长度变化
const handleSizeChange = async (pageSize) => {
    employeesSearchForm.value.pageSize = pageSize
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await getData().then((resolve) => {
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



</script>

<style scoped lang="less">
:deep(.el-button) {
    height: 40px;
    line-height: 40px;
}

:deep(.el-pagination) {
    width: 100%;

}

.light {
    :deep(.el-table) {
        height: 480px;
        background: transparent;

        thead {
            tr {
                background: transparent;

                .el-table__cell {

                    background: transparent;
                    text-align: center;

                    .cell {
                        font-size: 16px;
                        font-weight: bold;
                        color: #333;
                    }
                }
            }
        }

        tbody {
            tr {
                background: transparent;

                .el-table__cell {
                    text-align: center;
                    background: transparent;

                    .cell {
                        font-size: 16px;
                        background: transparent;

                        color: #333;
                    }
                }
            }

        }

        .hover-row .el-table__cell {
            background: rgba(255, 255, 255, .1)
        }
    }
}

.dark {
    :deep(.el-table) {
        height: 480px;
        background: transparent;

        thead {
            tr {
                background: transparent;

                .el-table__cell {

                    background: transparent;
                    text-align: center;

                    .cell {
                        font-size: 16px;
                        font-weight: bold;
                        color: #fff;
                    }
                }
            }
        }

        tbody {
            tr {
                background: transparent;

                .el-table__cell {
                    text-align: center;
                    background: transparent;

                    .cell {
                        font-size: 16px;
                        background: transparent;

                        color: #fff;
                    }
                }
            }

        }

        .hover-row .el-table__cell {
            background: rgba(0, 0, 0, .1)
        }
    }
}
</style>


<style scoped lang="less">
.StaffMsgTable {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    box-sizing: border-box;
}

.light {
    :deep(.el-pagination__goto) {
        color: #333333 !important;
        font-size: 16px;
        font-weight: bold;
    }

    :deep(.el-pagination__classifier) {
        color: #333333 !important;
        font-size: 16px;
        font-weight: bold;
    }

    :deep(.el-pagination__total) {
        color: #333333 !important;
        font-size: 16px;
        font-weight: bold;
    }
}

.dark {
    :deep(.el-pagination__goto) {
        color: #EBEAEA !important;
        font-size: 16px;
        font-weight: bold;
    }

    :deep(.el-pagination__classifier) {
        color: #EBEAEA !important;
        font-size: 16px;
        font-weight: bold;
    }

    :deep(.el-pagination__total) {
        color: #EBEAEA !important;
        font-size: 16px;
        font-weight: bold;
    }
}
</style>
