<template>
    <Card class="table" :theme="theme">
        <template v-slot:title>
            人员信息表<el-button  style="margin-left:15px;  height: auto;line-height: unset" link type="primary" size="large" @click="getData();reload=false" v-if="reload">您有新的内容可刷新</el-button>
        </template>
        <template v-slot:body>
            
            <div class="StaffMsgTable" :class="[theme === 'light' ? 'light' : 'dark']">
                <el-table :data="dimissionList" style="width: 100%;margin: 10px 0px; height:calc(100% - 100px) ;" border>
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
                    <el-table-column :resizable="false" prop="resignTime" label="离职时间" min-width="50">
                        <template #default="scope">
                            <span>
                                {{ GMTToStr(scope.row.resignTime) }}
                            </span>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" fixed="right" label="操作栏"
                        v-if="hasReturnStaffTable">
                        <template #default="scope">
                            <el-button v-if="hasReturnStaffTable" size="small" @click="isResign(scope.row)"
                                type="primary">设置为在职员工状态</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-model:current-page="dimissionSearchForm.pageNo"
                    v-model:page-size="dimissionSearchForm.pageSize" :page-sizes="[5, 8, 15, 30]"
                    layout=" jumper, total,->, prev, pager, next,sizes," :total="dimissionTotal" :background="true"
                    @current-change="handleCurrentChange" @size-change="handleSizeChange" />
            </div>
        </template>
    </Card>
    <Dialog class="confirmDialog" ref="confirmDialog" width="15%" top="15%">
        <template v-slot:header>
            <span :style="{ color: themeType ? '#333' : '#ebeaea' }">确认弹窗</span>
        </template>
        <template v-slot:body>
            <div :class="themeType ? 'lightFont' : 'darkFont'">
                确认将{{ resignStaff.staffName }}设置为在职员工吗?
            </div>
        </template>
        <template v-slot:footer>
            <el-button @click="confirmDialog.dialogStatus = false"><el-icon class="el-icon--right">
                    <CloseBold />
                </el-icon> 取消</el-button>
            <el-button type="primary" @click="handleReturnResign"> <el-icon class="el-icon--right">
                    <Select />
                </el-icon> 确认 </el-button>
        </template>
    </Dialog>
</template>


<script setup>
import { ref, computed, onMounted, getCurrentInstance } from 'vue';
// 格式化时间
//API
import dimission from '../../../api'
import socket from "../../../util/socket"
//格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入dimission仓库
import { useDimissionStore } from '../../../stores/dimission'

//获取全局挂载
let internalInstance = getCurrentInstance();

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

// 使用login仓库
let loginStore = useLoginStore()

// 使用layout仓库
let layoutStore = useLayoutStore()

// 使用dimission仓库
let dimissionStore = useDimissionStore()

//重载
let reload = ref(false)

//等待动画
let loadingInstance = ref(null)

//离职员工
let resignStaff = ref(null)

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// dimission仓库的state数据
const {
    //员工信息
    dimissionList,
    //员工总数
    dimissionTotal,
    // 员工信息搜索信息表单
    dimissionSearchForm
} = storeToRefs(dimissionStore)


// login仓库的state数据
const {
    // 权限列表
    authorityList
} = storeToRefs(loginStore)


// dimission仓库的action方法
const {
    //筛选员工信息
    filterDimissionListData,
} = dimissionStore

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

// 是否有设置员工为离职的权限
const hasReturnStaffTable = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "returnStaffTable"
    })
    return index !== -1
})


//确认对话框
let confirmDialog = ref(null)


// 是否设置为离职员工
const isResign = async (item) => {
    confirmDialog.value.dialogStatus = true
    resignStaff.value = item

}

// 设置为移回员工表
const handleReturnResign = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await dimission.reqReturnStaff(resignStaff.value.staffId).then(async resolve => {
        socket.emit("staff","")
        socket.emit("resign","")
        if (dimissionList.value.length === 1) {
            dimissionSearchForm.value.pageNo = dimissionSearchForm.value.pageNo - 1
            if (dimissionSearchForm.value.pageNo === 0) {
                dimissionSearchForm.value.pageNo = 1
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
        $ElMessage({
            message: reject.message,
            type: "error"
        })
    })
}

//获取数据
const getData = async () => {
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

//页码变化
const handleCurrentChange = async (pageNo) => {
    dimissionSearchForm.value.pageNo = pageNo
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
    dimissionSearchForm.value.pageSize = pageSize
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
    socket.on("resignUpdate", function (data) {
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
