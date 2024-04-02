<template>
    <Card class="table" title="离职员工申请" :theme="theme">
        <template v-slot:body>
            <div class="AuditList" :class="[theme === 'light' ? 'light' : 'dark']">
                <el-table :data="auditList" style="width: 100%;margin: 10px 0px; height:calc(100% - 60px) ;" border>
                    <el-table-column :resizable="false" prop="staffId" label="员工号" min-width="35" />
                    <el-table-column :resizable="false" prop="staffName" label="员工姓名" min-width="55" />
                    <el-table-column :resizable="false" prop="content" label="内容" min-width="250" />
                    <el-table-column :resizable="false" prop="dateTime" label="发送时间" min-width="50">
                        <template #default="scope">
                            <span>
                                {{ GMTToStr(scope.row.dateTime) }}
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="dateTime" label="操作栏" min-width="50" v-if="hasUpdateResignReviewStatus">
                        <template #default="scope">
                            <div class="btn_wrap" v-if="scope.row.status === '待审核'">
                                <el-button size="small" @click="handAudit(scope.row, '审核驳回')"
                                    type="warning">审核驳回</el-button>
                                <el-button size="small" @click="readyAudit(scope.row)" type="danger">审核通过</el-button>
                            </div>
                            <span style="line-height: 40px;" v-else
                                :style="{ color: scope.row.status === '审核通过' ? '#67C23A' : '#F56C6C' }">
                                {{ scope.row.status }}
                            </span>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-model:current-page="pageNo" :page-size="15"
                    layout=" jumper, total,->, prev, pager, next," :total="auditTotal" :background="true"
                    @current-change="handleCurrentChange" />
            </div>

        </template>
    </Card>
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
            <el-button type="primary" @click="handAudit(resignStaff, '审核通过')"> <el-icon class="el-icon--right">
                    <Select />
                </el-icon> 确认 </el-button>
        </template>
    </Dialog>

</template>


<script setup>
import { ref, onMounted, computed,getCurrentInstance } from 'vue';
// 格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入dimission仓库
import { useDimissionStore } from '../../../stores/dimission'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'
// 审核接口
import dimission from '../../../api'

//获取全局挂载
let internalInstance = getCurrentInstance();

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

// 使用layout仓库
let layoutStore = useLayoutStore()

// 使用dimission仓库
let dimissionStore = useDimissionStore()

// 获取login仓库
let loginStore = useLoginStore()

//等待动画
let loadingInstance = ref(null)

//props
const props = defineProps({
    status: {
        type: String,
        default: "待审核"
    }
})

// login仓库的state数据
const {
    //权限列表
    authorityList,
} = storeToRefs(loginStore)

//确认对话框
let confirmDialog = ref(null)

//离职员工
let resignStaff = ref(null)

// 页码
let pageNo = ref(1)

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// dimission仓库的state数据
const {
    //离职申请信息
    auditList,
    //离职申请信息总数
    auditTotal,
} = storeToRefs(dimissionStore)

// feedback仓库的action方法
const {
    //筛选离职申请信息
    getAuditListData,
} = dimissionStore


//获取数据
const getData = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await getAuditListData(props.status, pageNo.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})


// 是否有设置员工为离职的权限
const hasUpdateResignReviewStatus = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "updateResignReviewStatus"
    })
    return index !== -1
})



// 准备通过
const readyAudit = (row) => {
    resignStaff.value = row
    confirmDialog.value.dialogStatus = true
}

//修改审批
const handAudit = async (row, status) => {
    if (status === '审核驳回') {
        //动画开始
        loadingInstance.value = ElLoading.service({ fullscreen: true })
        await dimission.reqUpdateStatus({ opid: row.id, staffId: row.staffId, status: '审核驳回' }).then(async () => {
            $ElMessage({
                message: "审核驳回",
                type: "success"
            })
            await getData()
            //动画结束
            loadingInstance.value.close()
        }).catch(() => {
            $ElMessage({
                message: "审核失败,请联系管理员",
                type: "error"
            })
            loadingInstance.value.close()
        })
    } else {
        //动画开始
        loadingInstance.value = ElLoading.service({ fullscreen: true })
        await dimission.reqUpdateStatus({ opid: row.id, staffId: row.staffId, status: '审核通过' }).then(async () => {
            $ElMessage({
                message: "审核通过",
                type: "success"
            })
            await getData()
            //动画结束
            loadingInstance.value.close()
            //隐藏对话框
            confirmDialog.value.dialogStatus = false
        }).catch(() => {
            $ElMessage({
                message: "审核失败,请联系管理员",
                type: "error"
            })
            loadingInstance.value.close()
        })
    }
}

//页码变化
const handleCurrentChange = async (pageNo) => {
    feedbackForm.value.pageNo = pageNo
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

    .AuditList {
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
</style>
