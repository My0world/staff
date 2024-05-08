<template>
    <Card class="table" title="请假信息表" :theme="theme">
        <template v-slot:body>
            <div class="StaffMsgTable" :class="[theme === 'light' ? 'light' : 'dark']">
                <el-table :data="askforleaveData" style="width: 100%;margin: 10px 0px; height:calc(100% - 60px) ;"
                    border>
                    <el-table-column :resizable="false" prop="staffName" label="部门" min-width="20">
                        <template #default="scope">
                            {{ scope.row.departName }}
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="staffId" label="员工ID" min-width="20" />
                    <el-table-column :resizable="false" prop="staffName" label="姓名" min-width="50" />
                    <el-table-column :resizable="false" prop="content" label="请假理由" min-width="50" />
                    <el-table-column :resizable="false" prop="startTime" label="假期开始时间" min-width="25">
                        <template #default="scope">
                            <span>
                                {{ GMTToStr(scope.row.startTime) }}
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="endTime" label="假期结束时间" min-width="25">
                        <template #default="scope">
                            <span>
                                {{ GMTToStr(scope.row.endTime) }}
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="dateTime" label="发送日期" min-width="25">
                        <template #default="scope">
                            <span>
                                {{ GMTToStr(scope.row.dateTime) }}
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" fixed="right" label="操作栏" min-width="25">
                        <template #default="scope">
                            <el-button size="small" @click="handleExamine(scope.row)" v-if="scope.row.status === '待审核' && hasCheckVacate"
                                type="warning">待审核</el-button>
                            <span size="small" :style="{ color: scope.row.status === '审核通过' ? '#67C23A' : '#F56C6C' }"
                                v-else type="warning">{{ scope.row.status }}</span>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-model:current-page="vacationSearchForm.pageNo"
                    v-model:page-size="vacationSearchForm.pageSize" :page-sizes="[5, 8, 15, 30]"
                    layout=" jumper, total,->, prev, pager, next,sizes," :total="askforleaveTotal" :background="true"
                    @current-change="handleCurrentChange" @size-change="handleSizeChange" />
            </div>

        </template>
    </Card>
    <Dialog class="confirmDialog" ref="examineDialog" width="15%" top="15%">
        <template v-slot:header>
            <span :style="{ color: themeType ? '#333' : '#ebeaea' }">审核</span>
        </template>
        <template v-slot:body>
            <div :class="themeType ? 'lightFont' : 'darkFont'">

                是否通过{{ updateRow.staffName }}员工的请假?

            </div>

        </template>

        <template v-slot:footer>
            <el-button @click="handleReject">
                <el-icon class="el-icon--right">
                    <CloseBold />
                </el-icon>
                否决
            </el-button>
            <el-button type="primary" @click="handleAllow">
                <el-icon class="el-icon--right">
                    <Select />
                </el-icon>
                允许
            </el-button>
        </template>
    </Dialog>
</template>


<script setup>
import { ref, computed, onMounted, getCurrentInstance } from 'vue';
// API
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

let updateRow = ref("")

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
    //员工考勤搜索信息表单
    vacationSearchForm,
    //考勤记录总数
    askforleaveTotal,
    //请假历史记录
    askforleaveData
} = storeToRefs(employeesStore)

//审核对话框
let examineDialog = ref(null)

//login仓库的state数据
const {
    // 权限列表
    authorityList,
    //部门id
    departId
} = storeToRefs(loginStore)

//审核请假
const hasCheckVacate = computed(()=>{
    return authorityList.value.indexOf("checkVacate") !== -1
})

// employees仓库的action方法
const {
    //筛选请假记录
    filterAskforleaveData
} = employeesStore

// 主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

//确认框
const handleExamine = (row) => {
    updateRow.value = row
    examineDialog.value.dialogStatus = true
}

// 获取数据
const getData = async () => {
    
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterAskforleaveData(vacationSearchForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//页码变化
const handleCurrentChange = async (pageNo) => {
    vacationSearchForm.value.pageNo = pageNo
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
    vacationSearchForm.value.pageSize = pageSize
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

//允许
const handleAllow = async () => {
    // 动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await employees.reqEditAskforleave(updateRow.value.id,'审核通过').then(async resolve => {
        await getData()
        loadingInstance.value.close()
        examineDialog.value.dialogStatus = false
        $ElMessage({
            message: "审核通过",
            type: "success"
        })
    }, reject => {
        loadingInstance.value.close()
        $ElMessage({
            message: "审核失败，请联系管理员",
            type: "error"
        })
    })
}

//拒绝
const handleReject = async () => {
    // 动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await employees.reqEditAskforleave(updateRow.value.id,'审核驳回').then(async resolve => {
        await getData()
        loadingInstance.value.close()
        examineDialog.value.dialogStatus = false
        $ElMessage({
            message: "审核驳回",
            type: "success"
        })
    }, reject => {
        loadingInstance.value.close()
        $ElMessage({
            message: "审核失败，请联系管理员",
            type: "error"
        })
    })
}

onMounted(async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    vacationSearchForm.value.departId = departId.value
    await getData().then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
})



</script>

<style lang="less">
.el-drawer__title {
    font-size: 16px
}
</style>

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

.dataItem {
    margin: 15px;
    margin-right: 0px;
    box-sizing: border-box;
    padding: 15px;
    padding-bottom: 0px;
    border-radius: 10px;
    border: 1px solid #ebeaea;
}

.dataItem:nth-of-type(1) {
    margin-top: 0px !important;
}

.dataItem:last-of-type {
    margin-bottom: 0px !important;
}
</style>
