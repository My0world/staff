<template>
    <Card class="table" title="操作记录" :theme="theme">
        <template v-slot:body>
            <div class="FeedbackList" :class="[theme === 'light' ? 'light' : 'dark']">
                <el-table :data="feedbackList" style="width: 100%;margin: 10px 0px; height:calc(100% - 60px) ;" border>
                    <el-table-column :resizable="false" prop="send_staffId" label="员工号" min-width="35" />
                    <el-table-column :resizable="false" prop="send_staffName" label="员工姓名" min-width="45" />
                    <el-table-column :resizable="false" prop="content" label="内容" min-width="50" />
                    <el-table-column :resizable="false" prop="dateTime" label="发送时间" min-width="50">
                        <template #default="scope">
                            <span>
                                {{ GMTToStr(scope.row.dateTime) }}
                            </span>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-model:current-page="feedbackForm.pageNo" :page-size="12"
                    layout=" jumper, total,->, prev, pager, next," :total="total" :background="true"
                    @current-change="handleCurrentChange" />
            </div>

        </template>
    </Card>

</template>


<script setup>
import { ref, onMounted } from 'vue';
// 格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入feedback仓库
import { useFeedbackStore } from '../../../stores/feedback'


//抽屉
let drawer = ref(false)

// 使用layout仓库
let layoutStore = useLayoutStore()

// 使用operatingData仓库
let feedbackStore = useFeedbackStore()

//等待动画
let loadingInstance = ref(null)

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

// feedback仓库的state数据
const {
    //反馈信息
    feedbackList,
    //反馈总数
    total,
    // 反馈信息搜索信息表单
    feedbackForm
} = storeToRefs(feedbackStore)


// feedback仓库的action方法
const {
    //筛选反馈信息
    filterFeedbackData,
} = feedbackStore


// 查看详情
const handleDetail = (row) => {
    drawer.value = true
    myhtml.value = row.content
}



//获取数据
const getData = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await filterFeedbackData(feedbackForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
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

    .FeedbackList {
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
