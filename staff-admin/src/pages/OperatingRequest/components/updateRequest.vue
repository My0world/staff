<template>
    <Card class="item" title="请求修改员工信息" :theme="theme">
        <template v-slot:body>
            <div class="container" :class="theme">
                <div class="msg">
                    <p>
                        <span>请求者员工姓名：</span>
                        <span>{{ data.staffName }}</span>
                    </p>
                    <p>
                        <span>请求时间：</span>
                        <span>{{ data.datetime }}</span>
                    </p>
                </div>

                <div class="data">
                    <div class="data_item">
                        <p>修改前</p>
                        <p>
                            <span>部门名称：</span>
                            <span>{{ data.data.oldData.department_Name }}</span>
                        </p>
                        <p>
                            <span>员工号：</span>
                            <span>{{ data.data.oldData.staffId }}</span>
                        </p>
                        <p>
                            <span>员工姓名：</span>
                            <span>{{ data.data.oldData.staffName }}</span>
                        </p>
                        <p>
                            <span>年龄：</span>
                            <span>{{ data.data.oldData.age }}</span>
                        </p>
                        <p>
                            <span>性别：</span>
                            <span>{{ data.data.oldData.sex }}</span>
                        </p>
                        <p>
                            <span>手机号码：</span>
                            <span>{{ data.data.oldData.phoneNum }}</span>
                        </p>
                        <p>
                            <span>职位：</span>
                            <span>{{ data.data.oldData.job }}</span>
                        </p>
                        <p>
                            <span>薪资：</span>
                            <span>{{ data.data.oldData.salary }}</span>
                        </p>
                        <p>
                            <span>进入时间：</span>
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
                            <span>部门名称：</span>
                            <span>{{ data.data.newData.department_Name }}</span>
                        </p>
                        <p>
                            <span>员工号：</span>
                            <span>{{ data.data.newData.staffId }}</span>
                        </p>
                        <p>
                            <span>员工姓名：</span>
                            <span>{{ data.data.newData.staffName }}</span>
                        </p>
                        <p>
                            <span>年龄：</span>
                            <span>{{ data.data.newData.age }}</span>
                        </p>
                        <p>
                            <span>性别：</span>
                            <span>{{ data.data.newData.sex }}</span>
                        </p>
                        <p>
                            <span>手机号码：</span>
                            <span>{{ data.data.newData.phoneNum }}</span>
                        </p>
                        <p>
                            <span>职位：</span>
                            <span>{{ data.data.newData.job }}</span>
                        </p>
                        <p>
                            <span>薪资：</span>
                            <span>{{ data.data.newData.salary }}</span>
                        </p>
                        <p>
                            <span>进入时间：</span>
                            <span>{{ data.data.newData.entryTime }}</span>
                        </p>
                    </div>
                </div>
                <div class="btn_wrap">
                    <el-button type="primary" size="large" @click="handleExamine">审核</el-button>
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
            <el-button><el-icon class="el-icon--right">
                    <CloseBold />
                </el-icon> 否决</el-button>
            <el-button type="primary"> <el-icon class="el-icon--right">
                    <Select />
                </el-icon> 允许 </el-button>
        </template>
    </Dialog>
</template>


<script setup>
import { ref, computed } from 'vue';
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'

//prop
const prop = defineProps(["data"])

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



const handleExamine = () => {
    examineDialog.value.dialogStatus = true
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

                span:nth-of-type(2) {
                    font-weight: 100;
                }
            }
        }

        .data {
            display: flex;
            justify-content: space-between;

            .data_item {
                width: 47%;
                margin-bottom: 10px;

                p {
                    margin-bottom: 10px;

                    span:nth-of-type(2) {
                        font-weight: 100;
                    }
                }
            }

            .myicon {
                transform: translate(-3px);
                width: 6%;
                display: flex;
                height: 225px;
                align-items: center;
            }
        }
        .btn_wrap{
            text-align: right;
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
