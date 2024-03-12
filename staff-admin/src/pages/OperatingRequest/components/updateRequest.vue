<template>
    <Card class="item" title="请求修改员工信息" :theme="theme">
        <template v-slot:body>
            <div class="container" :class="theme">
                <div class="msg">
                    <p>
                        <span>请求者员工姓名:</span>
                        <span>{{ data.staffName }}</span>
                    </p>
                    <p>
                        <span>请求时间:</span>
                        <span>{{ data.datetime }}</span>
                    </p>
                </div>

                <div class="data">
                    <div class="data_item">
                        <p>修改前</p>
                        <p>
                            <span>部门名称:</span>
                            <span>{{ data.data.oldData.department_Name }}</span>
                        </p>
                        <!-- <p>
                            <span>员工号:</span>
                            <span>{{ data.data.oldData.staffId }}</span>
                        </p> -->
                        <p style="display: flex;">
                            <span style="display:block;width: 22%;">姓名:</span>
                            <span style="display:block;width: 78%;">{{ data.data.oldData.staffName }}</span>
                        </p>
                        <p>
                            <span>年龄:</span>
                            <span>{{ data.data.oldData.age }}</span>
                        </p>
                        <p>
                            <span>性别:</span>
                            <span>{{ data.data.oldData.sex }}</span>
                        </p>
                        <p>
                            <span>手机号:</span>
                            <span>{{ data.data.oldData.phoneNum }}</span>
                        </p>
                        <p>
                            <span>职位:</span>
                            <span>{{ data.data.oldData.job }}</span>
                        </p>
                        <p>
                            <span>薪资:</span>
                            <span>{{ data.data.oldData.salary }}</span>
                        </p>
                        <p>
                            <span>进入时间:</span>
                            <span>{{ data.data.oldData.entryTime }}</span>
                        </p>
                    </div>
                    <div class="myicon">
                        <span>
                            <el-icon>
                                <Switch />
                            </el-icon>
                        </span>

                    </div>

                    <div class="data_item">
                        <p>修改后</p>
                        <p>
                            <span>部门名称:</span>
                            <span>{{ data.data.newData.department_Name }}</span>
                        </p>
                        <!-- <p>
                            <span>员工号:</span>
                            <span>{{ data.data.newData.staffId }}</span>
                        </p> -->
                        <p style="display: flex;">
                            <span style="display:block;width: 22%;">姓名:</span>
                            <span style="display:block;width: 78%;">{{ data.data.newData.staffName }}</span>
                        </p>
                        <p>
                            <span>年龄:</span>
                            <span>{{ data.data.newData.age }}</span>
                        </p>
                        <p>
                            <span>性别:</span>
                            <span>{{ data.data.newData.sex }}</span>
                        </p>
                        <p>
                            <span>手机号:</span>
                            <span>{{ data.data.newData.phoneNum }}</span>
                        </p>
                        <p>
                            <span>职位:</span>
                            <span>{{ data.data.newData.job }}</span>
                        </p>
                        <p>
                            <span>薪资:</span>
                            <span>{{ data.data.newData.salary }}</span>
                        </p>
                        <p>
                            <span>进入时间:</span>
                            <span>{{ data.data.newData.entryTime }}</span>
                        </p>
                    </div>
                </div>
                <div class="btn_wrap">
                    <el-button type="primary" :disabled="!isAut" v-if="data.status === '待审核'" size="large" @click="handleExamine">{{
        data.status }}</el-button>
                    <span :class="theme" class="status" :style="{color: data.status === '审核通过' ? '#67C23A' :'#F56C6C' }" v-else>{{ data.status }}</span>
                </div>
            </div>
        </template>
    </Card>
    <Dialog class="examineDialog" ref="examineDialog" width="15%" top="15%">
        <template v-slot:header>
            <span :style="{ color: themeType ? '#333' : '#ebeaea' }">审核</span>
        </template>
        <template v-slot:body>
            <div :class="themeType ? 'lightFont' : 'darkFont'">

                是否允许{{ data.staffName }}用户的修改?

            </div>

        </template>
        
        <template v-slot:footer>
            <el-button @click='handleReject'><el-icon class="el-icon--right">
                    <CloseBold />
                </el-icon> 否决</el-button>
            <el-button type="primary" @click='handleAllow'> <el-icon class="el-icon--right">
                    <Select />
                </el-icon> 允许 </el-button>
        </template>
    </Dialog>
</template>


<script setup>
import { ref, computed,getCurrentInstance,inject } from 'vue';
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入操作请求审核仓库
import { useOperatingRequestStore } from '../../../stores/operatingRequest'
//API
import employees from '../../../api'
import operatingRequest from '../../../api'


// 使用operatingRequest仓库
let operatingRequestStore = useOperatingRequestStore()

// operatingRequest仓库的action方法
const {
    //获取操作请求审核数据
    getOpReviewData,
} = operatingRequestStore

//获取全局挂载
let internalInstance = getCurrentInstance();

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

//prop
const prop = defineProps(["data", "isAut", "status", "length"])

//页码
const pageNo = inject("pageNo");

//等待动画
let loadingInstance = ref(null)

// 使用layout仓库
let layoutStore = useLayoutStore()

//审核对话框
let examineDialog = ref(null)

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

//确认对话框
const handleExamine = () => {
    examineDialog.value.dialogStatus = true
}

//允许修改
const handleAllow = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await employees.reqUpdateStaff(
        { ...prop.data.data.newData, requestUserid: prop.data.staffId, opid: prop.data.id }
    ).then(async resolve => {
        if (prop.length === 1) {
            pageNo.value = pageNo.value - 1
            if (pageNo.value === 0) {
                pageNo.value = 1
            }
        }
        await getOpReviewData(prop.status, pageNo.value)
        loadingInstance.value.close()
        $ElMessage({
            message: "审核成功,允许修改",
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

//拒绝修改
const handleReject = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    await employees.reqUpdateStaff(
        { ...prop.data.data, requestUserid: prop.data.staffId, opid: prop.data.id }
    ).then(async resolve => {
        if (prop.length === 1) {
            pageNo.value = pageNo.value - 1
            if (pageNo.value === 0) {
                pageNo.value = 1
            }
        }
        await getOpReviewData(prop.status, pageNo.value)
        loadingInstance.value.close()
        $ElMessage({
            message: "审核成功,允许添加",
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

</script>


<style scoped lang="less">
.item {
    height: 420px;

    .container {
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;

        .msg {

            p {
                margin-bottom: 10px;

                span {
                    font-size: 16px;
                }

                span:nth-of-type(1) {
                    margin-right: 4px;
                }

                span:nth-of-type(2) {
                    font-weight: 100;
                }
            }
        }

        .data {
            display: flex;
            justify-content: space-between;
            height: 100%;
            overflow: auto;

            .data_item {
                width: 50%;
                margin-bottom: 10px;

                p {
                    margin-bottom: 10px;

                    span {
                        font-size: 16px;
                    }

                    span:nth-of-type(1) {
                        margin-right: 4px;
                    }

                    span:nth-of-type(2) {
                        font-weight: 100;

                    }
                }
            }

            .myicon {
                transform: translate(-15px);
                width: 6%;
                display: flex;
                height: 225px;
                align-items: center;
            }
        }

        .btn_wrap {
            text-align: right;

            .status {
                padding: 12px 20px;
                box-sizing: border-box;
                line-height: 40px;
                font-weight: bold;
            }
        }


    }

    .light {
        color: #333;
    }

    .dark {
        color: rgb(235, 234, 234);
    }
}

.examineDialog {
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
