<template>
    <Card class="table" title="考勤表" :theme="theme">
        <template v-slot:body>
            <div class="StaffMsgTable" :class="[theme === 'light' ? 'light' : 'dark']">
                <el-table :data="checkingInData" style="width: 100%;margin: 10px 0px; height:calc(100% - 60px) ;"
                    border>
                    <el-table-column :resizable="false" prop="staffId" label="员工ID" min-width="35" />
                    <el-table-column :resizable="false" prop="staffName" label="姓名" min-width="50" />
                    <el-table-column :resizable="false" prop="date" label="日期" min-width="50">
                        <template #default="scope">
                            <span>
                                {{ scope.row.date }}
                                <!-- {{ GMTToStr(scope.row.date) }} -->
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="startTime" label="签到时间" min-width="50">
                        <template #default="scope">
                            <span>
                                {{ scope.row.startTime }}
                                <!-- {{ GMTToStr(scope.row.startTime) }} -->
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="endTime" label="签退时间" min-width="50">
                        <template #default="scope">
                            <span>
                                {{ scope.row.endTime }}
                                <!-- {{ GMTToStr(scope.row.endTime) }} -->
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="status" label="状态" min-width="50" />
                    <el-table-column :resizable="false" fixed="right" label="操作栏">
                        <template #default="scope">
                            <el-button size="small" v-if="scope.row.status !== '正常' && hasEditCheckingIn"
                                @click="handleUpdate(scope.row)" type="warning">修改</el-button>
                            <el-button size="small" @click="vacationDetail(scope.row)" type="primary">查看请假记录</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-model:current-page="checkingInSearchForm.pageNo"
                    v-model:page-size="checkingInSearchForm.pageSize" :page-sizes="[5, 8, 15, 30]"
                    layout=" jumper, total,->, prev, pager, next,sizes," :total="checkingInTotal" :background="true"
                    @current-change="handleCurrentChange" @size-change="handleSizeChange" />
            </div>
        </template>
    </Card>
    <el-drawer v-model="upDrawer" :title="'修改' + upDataRow.date + '考勤状态'">
        <el-form label-width="130px">
            <el-form-item label="员工ID：">{{ upDataRow.staffId }}</el-form-item>
            <el-form-item label="姓名：">{{ upDataRow.staffName }}</el-form-item>
            <el-form-item label="日期：">{{ upDataRow.date }}</el-form-item>
            <el-form-item label="签到时间：">{{ upDataRow.startTime }}</el-form-item>
            <el-form-item label="签退时间：">{{ upDataRow.endTime }}</el-form-item>
            <el-form-item label="状态：">
                <el-select v-model="upDataRow.status" placeholder="Select" size="large" style="width: 240px">
                    <el-option label="正常" value="正常" />
                    <el-option label="请假" value="请假" />
                    <el-option label="迟到" value="迟到" />
                    <el-option label="早退" value="早退" />
                    <el-option label="旷工" value="旷工" />
                </el-select>
            </el-form-item>
        </el-form>
        <template #footer>
            <div style="flex: auto">
                <el-button @click="upDrawer = !upDrawer">取消</el-button>
                <el-button type="primary" @click="confirmClick">确认</el-button>
            </div>
        </template>
    </el-drawer>

    <el-drawer v-model="vacationDrawer" :title="vacationDataRow.staffName + '的请假记录'">
        <el-form label-width="100px">
            <el-row>
                <el-col :span="12">
                    <el-form-item label="开始日期：">
                        <el-date-picker @change="handelSearchTime" value-format="YYYY-MM-DD" v-model="form.startTime" type="date"
                            placeholder="请选择开始日期" />
                    </el-form-item>
                </el-col>
                <el-col :span="12">
                    <el-form-item label="状态：">
                        <el-select @change="handelSearchStatus" clearable v-model="form.status" placeholder="请选择审核状态">
                            <el-option label="审核通过" value="审核通过" />
                            <el-option label="审核驳回" value="审核驳回" />
                        </el-select>
                    </el-form-item>
                </el-col>
            </el-row>
            <div>
                <div class="dataItem" v-for="i in askforleaveData" :key="i.id">
                    <div class="wrap">
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="部门：">
                                    管理层
                                </el-form-item>
                            </el-col>
                            <el-col :span="12">
                                <el-form-item label="审核状态：">
                                    {{ i.status }}
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="24">
                                <el-form-item label="请假理由：">
                                    {{ i.content }}
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="开始日期：">
                                    {{ GMTToStr(i.startTime) }}

                                </el-form-item>
                            </el-col>
                            <el-col :span="12">
                                <el-form-item label="结束日期：">
                                    {{ GMTToStr(i.endTime) }}
                                </el-form-item>
                            </el-col>
                        </el-row>
                        <el-row>
                            <el-col :span="12">
                                <el-form-item label="发送日期：">
                                    {{ GMTToStr(i.dateTime) }}
                                </el-form-item>
                            </el-col>
                        </el-row>
                    </div>
                </div>
            </div>

        </el-form>
    </el-drawer>
</template>


<script setup>
import { ref, computed, onMounted, getCurrentInstance, reactive } from 'vue';
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

//查看请假历史记录
let form = reactive({
    startTime: "",
    status: ""
})

//修改考勤状态抽屉
let upDrawer = ref(false)

//查看请假记录抽屉
let vacationDrawer = ref(false)

// 使用login仓库
let loginStore = useLoginStore()

// 使用layout仓库
let layoutStore = useLayoutStore()

// 使用employees仓库
let employeesStore = useEmployeesStore()

//等待动画
let loadingInstance = ref(null)

//要更改的数据
let upDataRow = ref({})

//一位员工请假记录
let vacationDataRow = ref({})

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// employees仓库的state数据
const {
    //员工考勤搜索信息表单
    checkingInSearchForm,
    //考勤记录总数
    checkingInTotal,
    //考勤信息
    checkingInData,
    //请假历史记录
    askforleaveData
} = storeToRefs(employeesStore)

//login仓库的state数据
const {
    // 权限列表
    authorityList,
    //部门id
    departId
} = storeToRefs(loginStore)

// employees仓库的action方法
const {
    //筛选考勤记录
    filterCheckingInData,
    //筛选请假记录
    filterAskforleaveData
} = employeesStore


// 考勤状态修改
function handleUpdate(row) {
    upDrawer.value = true
    upDataRow.value = { ...row }

}

//请假数据时间筛选
async function handelSearchTime(v) {
    await filterAskforleaveData({ staffId: vacationDataRow.value.staffId,dateTime:form.startTime,status:form.status })
}

//请假数据状态筛选
async function handelSearchStatus(v) {
    await filterAskforleaveData({ staffId: vacationDataRow.value.staffId,dateTime:form.startTime,status:form.status })
}

//查看请假记录
async function vacationDetail(row) {
    vacationDrawer.value = true
    vacationDataRow.value = { ...row }
    await filterAskforleaveData({ staffId: vacationDataRow.value.staffId,dateTime:form.startTime,status:form.status })
}


//是否可以修改员工考勤
const hasEditCheckingIn = computed(() => {
    return authorityList.value.indexOf("editCheckingIn") !== -1
})



// 获取数据
const getData = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterCheckingInData(checkingInSearchForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//页码变化
const handleCurrentChange = async (pageNo) => {
    checkingInSearchForm.value.pageNo = pageNo
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
    checkingInSearchForm.value.pageSize = pageSize
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

//提交修改
async function confirmClick() {
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await employees.reqEditCheckingIn({ id: upDataRow.value.id, status: upDataRow.value.status }).then(async (res) => {
        $ElMessage({
            message: "修改成功",
            type: "success"
        })
        await getData()
        upDrawer.value = false
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        $ElMessage({
            message: "修改失败",
            type: "error"
        })
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
