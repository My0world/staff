<template>
    <div class="send">
        <el-row :gutter="20" class="container">
            <el-col :span="24" style="height: 100%;">
                <Card class="search" title="查询条件" :theme="theme" :class="[theme === 'light' ? 'light' : 'dark']">
                    <template v-slot:body>
                        <el-form :model="form" label-width="27%">
                            <el-row :gutter="15">
                                <el-col :span="6">
                                    <el-form-item label="关键字:">
                                        <el-input style="width: 90%;" v-model="form.searchText" size="large"
                                            placeholder="请输入内容" class="input" :suffix-icon="Search" clearable />
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
            </el-col>
        </el-row>
        <el-row :gutter="20" class="container">
            <el-col :span="24" style="height: 100%;">
                <Card class="table" title="操作记录" :theme="theme">
                    <template v-slot:body>
                        <div class="OperatingList" :class="[theme === 'light' ? 'light' : 'dark']">
                            <el-table :data="receiveList" style="width: 100%;margin: 10px 0px; height:calc(100% - 60px) ;"
                                border>
                                <el-table-column :resizable="false" prop="send_staffName" label="发送人" min-width="100" />
                                <el-table-column :resizable="false" prop="departName" label="接收部门" min-width="135" />
                                <el-table-column :resizable="false" prop="title" label="标题" min-width="450" />
                                <el-table-column :resizable="false" prop="datetime" label="时间" min-width="100">
                                    <template #default="scope">
                                        <span>
                                            {{ GMTToStr(scope.row.datetime) }}
                                        </span>
                                    </template>
                                </el-table-column>
                                <el-table-column :resizable="false" fixed="right" label="操作栏">
                                    <template #default="scope">
                                        <el-button type="primary" link @click="handleDetail(scope.row)">查看</el-button>
                                    </template>
                                </el-table-column>
                            </el-table>
                            <el-pagination v-model:current-page="receiveForm.pageNo" :page-size="12"
                                layout=" jumper, total,->, prev, pager, next," :total="receiveTotal" :background="true"
                                @current-change="handleCurrentChange" />
                        </div>
                    </template>
                </Card>
            </el-col>
        </el-row>
    </div>
    <el-drawer v-model="detailDrawer" title="详情" size="30%">
        <el-form label-width="100px">
            <div>
                <el-row>
                    <el-col :span="24">
                        <el-form-item label="发送人：">
                            {{ detailRow.send_staffName }}
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item label="接收部门：">
                            {{ detailRow.departName }}
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="24">
                        <el-form-item label="标题：">
                            {{ detailRow.title }}
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="24">
                        <el-form-item label="内容：">
                            {{ detailRow.content }}
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row>
                    <el-col :span="12">
                        <el-form-item label="日期：">
                            {{ detailRow.datetime }}
                        </el-form-item>
                    </el-col>
                </el-row>


            </div>

        </el-form>
    </el-drawer>
</template>


<script setup>
import { onMounted, computed, reactive, onBeforeUnmount, ref } from "vue"
// 格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入operatingData仓库
import { useNoticeStore } from '../../../stores/notice'
//搜索
import { Search } from '@element-plus/icons-vue'

//详情抽屉
let detailDrawer = ref(false)

// 获取layout仓库
let layoutStore = useLayoutStore()

//详情
let detailRow = ref({})


// 使用notice仓库
let noticeStore = useNoticeStore()

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)


// employees仓库的action方法
const {
    //筛选操作记录信息
    filterReceiveData
} = noticeStore

// employees仓库的state数据
const {
    // 操作记录搜索信息表单
    receiveForm,
    //已发送的通知
    receiveList,
    //已发送通知总数
    receiveTotal,
} = storeToRefs(noticeStore)

//等待动画
let loadingInstance = ref(null)

// 筛选表单
const form = reactive({
    searchText: ""
})

//筛选操作
const handleFilter = async () => {
    receiveForm.value = {
        ...receiveForm.value, ...{
            searchText: form.searchText,
            pageNo: 1
        }
    }
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterReceiveData(receiveForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

// 清除搜索内容
const handleClearCard = async () => {
    form.time = ""
    form.searchText = ""
    receiveForm.value = {
        ...receiveForm.value, ...{
            searchText: "",
            pageNo: 1
        }
    }
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterReceiveData(receiveForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

function handleDetail(row) {
    detailDrawer.value = true
    detailRow.value = row
}


//获取数据
const getData = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterReceiveData(receiveForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//页码变化
const handleCurrentChange = async (pageNo) => {
    receiveForm.value.pageNo = pageNo
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

onBeforeUnmount(() => {
    handleClearCard()
})



</script>

<style scoped lang="less">
.send {
    margin-top: 17px;
    height: calc(100% - 17px);

    .container {
        overflow-y: auto;
        padding: 10px;
        padding-bottom: 0px;
        box-sizing: border-box;

        &:nth-last-of-type(1) {
            padding-top: 10px;
            height: calc(100% - 140px);
            padding-bottom: 10px;
        }
    }
}
</style>

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
<style lang="less">
.el-overlay {
    .el-drawer {

        .el-drawer__header {
            margin-bottom: 10px !important;
            
            .el-drawer__title{
                font-size: 16px;
            }
        }

        .add {
            div {
                p {
                    line-height: 24px;
                    margin-bottom: 10px;
                }
            }

            div:nth-of-type(1) {
                p:nth-of-type(1) {
                    font-weight: bolder;
                    font-size: 16px;
                }

                p:nth-of-type(2) {
                    font-size: 16px;
                }
            }

            div:nth-of-type(2) {
                display: flex;
                flex-wrap: wrap;
                align-items: center;

                p:nth-of-type(1) {
                    width: 100%;
                    border: none;
                    margin-right: 0px;
                }

                p {
                    display: flex;
                    border: 1px solid #eeeeee;
                    margin-right: 20px;

                    span:nth-of-type(1) {
                        display: block;
                        padding: 5px 16px;
                        background: #eeeeee;
                    }

                    span:nth-of-type(2) {
                        display: block;
                        padding: 5px 16px;
                    }

                }

            }
        }

        .update {
            div {
                p {
                    line-height: 24px;
                    margin-bottom: 10px;
                }
            }

            div:nth-of-type(1) {
                p:nth-of-type(1) {
                    font-weight: bolder;
                    font-size: 16px;
                }

                p:nth-of-type(2) {
                    font-size: 16px;
                }
            }

            div:nth-of-type(2),
            div:nth-of-type(3) {
                display: flex;
                flex-wrap: wrap;
                align-items: center;

                p:nth-of-type(1) {
                    width: 100%;
                    border: none;
                    margin-right: 0px;
                }

                p {
                    display: flex;
                    border: 1px solid #eeeeee;
                    margin-right: 20px;

                    span:nth-of-type(1) {
                        display: block;
                        padding: 5px 16px;
                        background: #eeeeee;
                    }

                    span:nth-of-type(2) {
                        display: block;
                        padding: 5px 16px;
                    }

                }

            }
        }

        .shortMsg {
            font-size: 24px;
        }
    }

    .light {
        background: #fff;

        .add {
            div {
                p {
                    color: #333;
                }
            }

            div:nth-of-type(2) {
                p {
                    border: 1px solid #eeeeee;

                    span:nth-of-type(1) {
                        background: #eeeeee;
                    }

                }
            }
        }

        .update {
            div {
                p {
                    color: #333;
                }
            }

            div:nth-of-type(2),
            div:nth-of-type(3) {
                p {
                    border: 1px solid #eeeeee;

                    span:nth-of-type(1) {
                        background: #eeeeee;
                    }

                }
            }
        }

        .shortMsg {
            color: #333;
        }
    }

    .dark {
        background: #333;

        .add {
            div {
                p {
                    color: #fff;
                }
            }

            div:nth-of-type(2) {
                p {
                    border: 1px solid #555;

                    span:nth-of-type(1) {
                        background: #555;
                    }

                }
            }
        }

        .update {
            div {
                p {
                    color: #fff;
                }
            }

            div:nth-of-type(2),
            div:nth-of-type(3) {
                p {
                    border: 1px solid #555;

                    span:nth-of-type(1) {
                        background: #555;
                    }

                }
            }
        }

        .shortMsg {
            color: #fff;
        }
    }
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
                        overflow: hidden;
                        text-overflow: ellipsis;
                        white-space: nowrap;

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

    .OperatingList {
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
