<template>
    <Card class="table" title="操作记录" :theme="theme">
        <template v-slot:body>
            <div class="OperatingList" :class="[theme === 'light' ? 'light' : 'dark']">
                <el-table :data="operatingList" style="width: 100%;margin: 10px 0px; height:calc(100% - 60px) ;" border>
                    <el-table-column :resizable="false" prop="id" label="编号" min-width="35" />
                    <el-table-column :resizable="false" prop="staffId" label="操作人员工号" min-width="45" />
                    <el-table-column :resizable="false" prop="staffName" label="操作人员工姓名" min-width="50" />
                    <el-table-column :resizable="false" prop="datetime" label="操作时间" min-width="50">
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
                <el-pagination v-model:current-page="operatingDataForm.pageNo" :page-size="12"
                    layout=" jumper, total,->, prev, pager, next," :total="total" :background="true"
                    @current-change="handleCurrentChange" />
            </div>

        </template>
    </Card>
    <el-drawer :class="[theme === 'light' ? 'light' : 'dark', 'drawer']" v-model="drawer" title="" direction="ttb">
        <div v-html="myhtml"></div>
    </el-drawer>

</template>


<script setup>
import { ref, computed, onMounted } from 'vue';
// 格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入operatingData仓库
import { useOperatingDataStore } from '../../../stores/operatingData'

let myhtml = ref("")

//抽屉
let drawer = ref(false)

// 使用layout仓库
let layoutStore = useLayoutStore()

// 使用operatingData仓库
let operatingDataStore = useOperatingDataStore()

//等待动画
let loadingInstance = ref(null)

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// operatingData仓库的state数据
const {
    //操作记录信息
    operatingList,
    //操作记录总数
    total,
    // 操作记录信息搜索信息表单
    operatingDataForm
} = storeToRefs(operatingDataStore)


// operatingData仓库的action方法
const {
    //筛选操作记录信息
    filterOperatingData,
} = operatingDataStore


// 查看详情
const handleDetail = (row) => {
    drawer.value = true
    myhtml.value = row.content
}



//获取数据
const getData = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterOperatingData(operatingDataForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//页码变化
const handleCurrentChange = async (pageNo) => {
    operatingDataForm.value.pageNo = pageNo
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

<style lang="less">
.el-overlay {
    .el-drawer {
    
        .el-drawer__header {
            margin-bottom: 10px !important;
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

            div:nth-of-type(2),div:nth-of-type(3) {
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
        .shortMsg{
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
            div:nth-of-type(2),div:nth-of-type(3) {
                p {
                    border: 1px solid #eeeeee;
                    span:nth-of-type(1) {
                        background: #eeeeee;
                    }

                }
            }
        }
        .shortMsg{
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
            div:nth-of-type(2),div:nth-of-type(3) {
                p {
                    border: 1px solid #555;
                    span:nth-of-type(1) {
                        background: #555;
                    }

                }
            }
        }
        .shortMsg{
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
