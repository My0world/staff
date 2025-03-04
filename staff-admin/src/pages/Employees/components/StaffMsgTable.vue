<template>
    <Card class="table" title="人员信息表" :theme="theme">
        <template v-slot:body>
            <div class="StaffMsgTable" :class="[theme === 'light' ? 'light' : 'dark']">
                <div class="operation">
                    <el-button type="primary" size="large" @click="handleAdd('添加', '添加信息已发送请等待审核')"
                        v-if="hasUserAddStaff">添加(需审核)</el-button>
                    <el-button type="primary" size="large" @click="handleAdd('添加')"
                        v-if="hasAdminAddStaff">添加</el-button>
                    <el-button type="primary" size="large" disabled
                        v-if="!hasAdminAddStaff && !hasUserAddStaff">添加</el-button>
                    <el-button link type="primary" size="large" @click="getData();reload=false" v-if="reload">您有新的内容可刷新</el-button>
                </div>
                <el-table :data="staffList" style="width: 100%;margin: 10px 0px; height:calc(100% - 100px) ;" border>
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
                            <el-button v-if="hasUserUpdateStaff" size="small"
                                @click="handleUpdate('修改', scope.row, '修改信息已发送请等待审核')"
                                type="warning">修改(需审核)</el-button>
                            <el-button v-if="hasAdminUpdateStaff" size="small" @click="handleUpdate('修改', scope.row)"
                                type="warning">修改</el-button>
                            <el-button v-if="hasSettingDimission" size="small" @click="isResign(scope.row)"
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
    <Dialog class="confirmDialog" ref="confirmDialog" width="15%" top="15%">
        <template v-slot:header>
            <span :style="{ color: themeType ? '#333' : '#ebeaea' }">确认弹窗</span>
        </template>
        <template v-slot:body>
            <div :class="themeType ? 'lightFont' : 'darkFont'">
                确认将{{ resignStaff.staffName }}员工设置为离职吗?
            </div>
        </template>
        <template v-slot:footer>
            <el-button @click="confirmDialog.dialogStatus = false"><el-icon class="el-icon--right">
                    <CloseBold />
                </el-icon> 取消</el-button>
            <el-button type="primary" @click="handleResign"> <el-icon class="el-icon--right">
                    <Select />
                </el-icon> 确认 </el-button>
        </template>
    </Dialog>
</template>


<script setup>
import { ref, computed, onMounted, getCurrentInstance,provide } from 'vue';
//添加和修改对话框
import StaffMsgDialog from "./StaffMsgDialog.vue"
//API
import employees from '../../../api'
import socket from "../../../util/socket"
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

//离职员工
let resignStaff = ref(null)

//重载
let reload = ref(false)
provide("reload",reload)

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

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

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
const handleAdd = (tit, msg) => {
    StaffMsgDialogRef.value.StaffMsgDialogShow(tit, null, msg)
}

//修改员工信息
const handleUpdate = (tit, item,msg) => {
    StaffMsgDialogRef.value.StaffMsgDialogShow(tit, item, msg)
}

//确认对话框
let confirmDialog = ref(null)

// 是否设置为离职员工
const isResign = async (item) => {
    confirmDialog.value.dialogStatus = true
    resignStaff.value = item

}

// 设置为离职员工
const handleResign = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await employees.reqResignStaff({ ...resignStaff.value, entryTime: GMTToStr(resignStaff.value.entryTime) }).then(async resolve => {
        socket.emit("resign","")
        socket.emit("staff","")
        if (staffList.value.length === 1) {
            employeesSearchForm.value.pageNo = employeesSearchForm.value.pageNo - 1
            if (employeesSearchForm.value.pageNo === 0) {
                employeesSearchForm.value.pageNo = 1
            }
        }
        await getData()
        //动画结束
        loadingInstance.value.close()
        confirmDialog.value.dialogStatus = false

        $ElMessage({
            message: resolve.message,
            type: "success"
        })
        reload.value = false
    }, reject => {
        //动画结束
        loadingInstance.value.close()
        confirmDialog.value.dialogStatus = false
    })
}



//获取数据
const getData = async () => {
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
    if (!hasAllStaffMsgView.value) {
        employeesSearchForm.value.departId = departId.value
    } else {
        employeesSearchForm.value.departId = ""
    }
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await getData().then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
    socket.on("staffUpdate", function (data) {
        reload.value = true
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
.table {
    height: 100%;
    display: flex;

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
}

.confirmDialog {
    .lightFont {
        color: #333;
        font-size: 16px;
        font-weight: bold;
        text-align: center;
    }

    .darkFont {
        color: #ebeaea;
        font-size: 16px;
        font-weight: bold;
        text-align: center;
    }
}
</style>
