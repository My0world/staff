<template>
    <Dialog class="formDialog" ref="formDialog" width="40%" top="15%" @handleClosed="handleClosed">
        <template v-slot:header>
            <span :style="{ color: themeType ? '#333' : '#ebeaea' }">{{ title }}</span>
        </template>

        <template v-slot:body>
            <el-form ref="FormRef" :rules="FormRules" label-width="37%"
                :class="{ feedback_main_light: themeType, feedback_main_dark: !themeType }" :model="FormData">
                <el-row :gutter="20" style="margin-bottom: 15px;">
                    <el-col :span="12">
                        <el-form-item label="部门:" prop="departId">
                            <el-select v-model="FormData.departId" placeholder="请选择部门" size="large"
                                :disabled="setDisabled">
                                <el-option v-for="i in departmentList" :key="i.departId" :label="i.department_Name"
                                    :value="i.departId" />
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="员工姓名:" prop="staffName">
                            <div class="input">
                                <el-input v-model="FormData.staffName" type="text" size="large" placeholder="请输入员工姓名" />
                            </div>
                        </el-form-item>
                    </el-col>

                </el-row>
                <el-row :gutter="20" style="margin-bottom: 15px;">
                    <el-col :span="12">
                        <el-form-item label="职位:" prop="job">
                            <el-select v-model="FormData.job" placeholder="请选择职位" size="large">
                                <el-option v-for="(i, index) in jobType" :key="index" :label="i" :value="i" />
                            </el-select>

                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="手机号码:" prop="phoneNum">
                            <div class="input">
                                <el-input @input="handleInput" v-model="FormData.phoneNum" type="text" size="large"
                                    placeholder="请输入手机号码" />
                            </div>
                        </el-form-item>
                    </el-col>

                </el-row>
                <el-row :gutter="20" style="margin-bottom: 15px;">
                    <el-col :span="12">
                        <el-form-item label="性别:" prop="sex">
                            <el-select v-model="FormData.sex" placeholder="请选择性别" size="large">
                                <el-option label="男" value="男" />
                                <el-option label="女" value="女" />
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="进入公司时间:" prop="entryTime">
                            <el-date-picker v-model="FormData.entryTime" type="date" size="large" placeholder="请选择日期"
                                format="YYYY-MM-DD" value-format="YYYY-MM-DD" />
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20">
                    <el-col :span="12">
                        <el-form-item label="年龄:" prop="age">
                            <el-input-number v-model="FormData.age" :precision="0" :step="1" size="large" />
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="薪资:" prop="salary">
                            <div style="position: relative;">
                                <el-input-number v-model="FormData.salary" :precision="1" size="large" />
                                <span class="unit">K</span>
                            </div>

                        </el-form-item>

                    </el-col>
                </el-row>
            </el-form>
        </template>

        <template v-slot:footer>
            <el-button size="large" @click="handleClosed">取消</el-button>
            <el-button size="large" @click="handleSubmit(FormRef)" type="primary">确认</el-button>
        </template>
    </Dialog>
</template>


<script setup>
// 引入pinia响应式
import { storeToRefs } from 'pinia'
//Vue
import { reactive, computed, ref, getCurrentInstance } from 'vue';
//防抖
import { debounce } from "lodash"
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入employees仓库
import { useEmployeesStore } from '../../../stores/employees'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'
//API
import employees from '../../../api'
//格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
//获取全局挂载
let internalInstance = getCurrentInstance();
// 使用employees仓库
let employeesStore = useEmployeesStore()
// 使用login仓库
let loginStore = useLoginStore()

//login仓库的state数据
const {
    // 权限列表
    authorityList,
    // 部门号
    departId
} = storeToRefs(loginStore)

//表单头部标题
let title = ref("")

//修改用的员工号
let staffId = ref(null)

//表单元素
let FormRef = ref(null)

//员工信息对话框
let formDialog = ref(null)

//等待动画
let loadingInstance = ref(null)

//提示信息
let message = ref(null)

//数值不能小于0
const noZore = (rule, value, callback) => {
    if (value <= 0) {
        callback(new Error('数值不能小于等于0'))
    } else {
        callback()
    }
}

// employees仓库的action方法
const {
    //筛选员工信息
    filterStaffData
} = employeesStore

// employees仓库的state数据
const {
    // 部门列表
    departmentList,
    // 职位类型
    jobType,
    // 员工信息搜索信息表单
    employeesSearchForm,
} = storeToRefs(employeesStore)

//表单规则
const FormRules = reactive({
    departId: [
        {
            required: true,
            message: '请选择部门',
            trigger: 'change',
        },
    ],
    staffName: [
        {
            required: true,
            message: '请输入姓名',
            trigger: 'change',
        },
    ],
    job: [
        {
            required: true,
            message: '请选择职位',
            trigger: 'change',
        },
    ],
    phoneNum: [
        {
            required: true,
            message: '请输入手机号码',
            trigger: 'change',
        },
    ],
    sex: [
        {
            required: true,
            message: '请选择性别',
            trigger: 'change',
        },
    ],
    age: [
        {
            required: true,
            message: '请输入年龄',
            trigger: 'change',
        },
        { validator: noZore, trigger: 'blur' }
    ],
    salary: [
        {
            required: true,
            message: '请输入薪资',
            trigger: 'change',
        },
        { validator: noZore, trigger: 'blur' }
    ],
    entryTime: [
        {
            required: true,
            message: '请选择日期',
            trigger: 'change',
        },
    ],
})

//表单数据
const FormData = reactive({
    departId: "",
    staffName: "",
    job: "",
    phoneNum: "",
    sex: "",
    age: 0,
    salary: 0,
    entryTime: ""
})

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

// 获取layout仓库
let layoutStore = useLayoutStore()

// layout仓库的state数据
const {
    // 主题
    theme
} = storeToRefs(layoutStore)

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

//设置不可使用
const setDisabled = computed(() => {
    //不可以修改部门
    if (title.value === '修改') {
        return true
    }
    else {
        let index = authorityList.value.findIndex((item) => {
            return item === 'allStaffMsgView'
        })
        if(index === -1){
            FormData.departId = departId.value
            return true
        }else{
            return false
        }
    }

})



//关闭对话框
const handleClosed = () => {
    FormData.departId = ""
    FormData.staffName = ""
    FormData.job = ""
    FormData.phoneNum = ""
    FormData.sex = ""
    FormData.age = 0
    FormData.salary = 0
    FormData.entryTime = ""
    formDialog.value.dialogStatus = false
}

//只允许输入数字
const handleInput = () => {
    FormData.phoneNum = FormData.phoneNum.replace(/[^\d]/g, '');
}

//信息提交
const handleSubmit = debounce(async (el) => {
    if (!el) return
    await el.validate(async (valid, fields) => {
        if (valid) {
            //动画开始
            loadingInstance.value = ElLoading.service({ fullscreen: true })
            // 是修改还是添加
            if (staffId.value !== null) {
                let salary = FormData.salary * 1000
                await employees.reqUpdateStaff({ ...FormData, staffId: staffId.value, salary }).then(async reslove => {
                    await filterStaffData(employeesSearchForm.value)
                    loadingInstance.value.close()
                    if (message.value) {
                        $ElMessage({
                            message: message.value,
                            type: "success"
                        })
                    } else {
                        $ElMessage({
                            message: "修改成功",
                            type: "success"
                        })
                    }

                }, reject => {
                    loadingInstance.value.close()
                    $ElMessage({
                        message: "失败，请联系管理员",
                        type: "error"
                    })
                })
            } else {
                let salary = FormData.salary * 1000
                await employees.reqAddStaff(
                    { ...FormData, salary }
                ).then(async resolve => {
                    await filterStaffData(employeesSearchForm.value)
                    FormData.departId = ""
                    FormData.staffName = ""
                    FormData.job = ""
                    FormData.phoneNum = ""
                    FormData.sex = ""
                    FormData.age = 0
                    FormData.salary = 0
                    FormData.entryTime = ""
                    loadingInstance.value.close()
                    if (message.value) {
                        $ElMessage({
                            message: message.value,
                            type: "success"
                        })
                    } else {
                        $ElMessage({
                            message: "添加成功",
                            type: "success"
                        })
                    }
                }, reject => {
                    loadingInstance.value.close()
                    $ElMessage({
                        message: "添加失败，请联系管理员",
                        type: "error"
                    })
                })
            }
        } else {
            $ElMessage({
                message: "请输入正确的内容",
                type: "error"
            })
        }
    })
}, 500)

defineExpose({
    //员工信息对话框显示
    StaffMsgDialogShow: (tit, item, msg) => {
        title.value = tit
        formDialog.value.dialogStatus = true
        message.value = msg
        if (item && item.staffId !== null) {
            staffId.value = item.staffId
            FormData.departId = item.departId
            FormData.staffName = item.staffName
            FormData.job = item.job
            FormData.phoneNum = item.phoneNum
            FormData.sex = item.sex
            FormData.age = item.age
            FormData.salary = item.salary / 1000
            FormData.entryTime = GMTToStr(item.entryTime)
        }
    }
})

</script>

<style scoped lang="less">
:deep(.el-dialog__body) {
    padding-bottom: 0px !important;
}

:deep(.el-form-item__label) {
    height: 40px !important;
    justify-content: center;
    align-items: center;
}

:deep(.el-select--large) {
    width: 100% !important;

    :deep(.el-tooltip__trigger) {
        width: 100% !important;

        :deep(.el-select--large) {
            width: 100% !important;
        }
    }
}




:deep(.el-button) {
    height: 40px;
    line-height: 40px;
    margin-right: 32px;
}

:deep(.el-divider--horizontal) {
    margin: 0px 0px 0.09375rem 0px;
}

:deep(.input) {
    width: 100% !important;

    :deep(.el-input) {
        width: 100% !important;
    }
}

:deep(.el-date-editor) {
    width: 100% !important;
}



:deep(.el-input-number) {
    width: 100% !important;

    :deep(.el-input) {
        width: 100% !important;
    }
}
</style>


<style scoped lang="less">
.formDialog {
    .feedback_main_light {
        width: 100%;

        :deep(.el-form-item__label) {
            display: flex;
            justify-content: center;
            font-size: 17px;
            color: #333 !important;
            user-select: none;
            width: 27%;
        }

        :deep(.el-form-item__content) {
            display: flex;
            justify-content: flex-start;
            width: 73%;

            .input {
                width: 100%
            }

            .el-form-item__error {
                font-size: 14px;
                margin-top: 3px;
            }
        }

    }

    .feedback_main_dark {
        width: 100%;

        :deep(.el-form-item__label) {
            display: flex;
            justify-content: center;
            font-size: 17px;
            color: #ebeaea !important;
            user-select: none;
            width: 27%;
        }

        :deep(.el-form-item__content) {
            display: flex;
            justify-content: flex-end;
            width: 73%;

            .input {
                width: 100%;
            }

            .el-form-item__error {
                font-size: 14px;
                margin-top: 3px;
            }
        }

    }

    .unit {
        position: absolute;
        z-index: 9999;
        top: 50%;
        right: 60px;
        transform: translateY(-47%);
    }
}
</style>
