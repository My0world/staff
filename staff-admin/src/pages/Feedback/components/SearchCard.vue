<template>
    <Card class="search" title="查询条件" :theme="theme" :class="[theme === 'light' ? 'light' : 'dark']">
        <template v-slot:body>
            <el-form :model="form" label-width="27%">
                <el-row :gutter="15">
                    <el-col :span="6">
                        <el-form-item label="进入公司时间:">
                            <el-date-picker v-model="form.time" type="daterange" range-separator="——"
                                start-placeholder="开始时间" end-placeholder="结束时间" value-format="YYYY-MM-DD"
                                :unlink-panels="true" size="large" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="6">
                        <el-form-item label="关键字:">
                            <el-input style="width: 90%;" v-model="form.searchText" size="large" placeholder="请输入搜索的姓名"
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
import { reactive, onBeforeUnmount, ref } from "vue"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入feedback仓库
import { useFeedbackStore } from '../../../stores/feedback'
//搜索
import { Search } from '@element-plus/icons-vue'


// 获取layout仓库
let layoutStore = useLayoutStore()


// 使用feedback仓库
let feedbackStore = useFeedbackStore()

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)


// feedback仓库的action方法
const {
    //筛选反馈信息
    filterFeedbackData
} = feedbackStore

// feedback仓库的state数据
const {
    // 反馈信息搜索信息表单
    feedbackForm,
} = storeToRefs(feedbackStore)

//等待动画
let loadingInstance = ref(null)

// 筛选表单
const form = reactive({
    time: "",
    searchText: ""
})

//筛选反馈
const handleFilter = async () => {
    if (!form.time) {
        form.time = ["", ""]
    }
    feedbackForm.value = {
        ...feedbackForm.value, ...{
            startTime: form.time[0],
            endTime: form.time[1],
            searchText: form.searchText
        }
    }
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

// 清除搜索内容
const handleClearCard = async () => {
    form.time = ""
    form.searchText = ""
    feedbackForm.value = {
        ...feedbackForm.value, ...{
            startTime: "",
            endTime: "",
            searchText: ""
        }
    }
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
