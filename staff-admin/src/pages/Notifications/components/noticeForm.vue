<template>
    <div class="noticeForm">
        <el-form label-position="right" :rules="FormRules" ref="form"
            :class="{ feedback_main_light: themeType, feedback_main_dark: !themeType }" :model="FormData"
            label-width="150px">
            <el-row>
                <el-col :span="10">
                    <el-form-item label="部门:" prop="departId">
                        <el-select v-model="FormData.departId" placeholder="请选择部门" size="large" :rules="FormRules"
                            :disabled="!hasNoticeForAll" :multiple="hasNoticeForAll">
                            <el-option v-for="i in departmentList" :key="i.departId" :label="i.department_Name"
                                :value="i.departId" />
                        </el-select>
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="10">
                    <el-form-item label="标题:" prop="title">
                        <el-input v-model="FormData.title" maxlength="20" size="large" placeholder="请输入标题"
                            show-word-limit type="text" />
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="17">
                    <el-form-item label="通知内容:" prop="content">
                        <el-input v-model="FormData.content" resize="none" :rows="20" type="textarea" size="large"
                            placeholder="请输入通知内容" />
                    </el-form-item>
                </el-col>
            </el-row>
            <el-row>
                <el-col :span="17">
                    <div style="padding-left:150px;box-sizing: border-box">
                        <el-button size="large" @click="resetForm">重置</el-button>
                        <el-button size="large" @click="submitForm(form)" type="primary">发送</el-button>
                    </div>

                </el-col>
            </el-row>
        </el-form>
    </div>
</template>


<script setup>
import { onMounted, reactive, ref, getCurrentInstance, computed } from "vue"
//API
import notice from '../../../api'
import socket from "../../../util/socket"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入employees仓库
import { useEmployeesStore } from '../../../stores/employees'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'

//获取全局挂载
let internalInstance = getCurrentInstance();

// 使用employees仓库
let employeesStore = useEmployeesStore()

// 使用login仓库
let loginStore = useLoginStore()

// 获取layout仓库
let layoutStore = useLayoutStore()

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

//等待动画
let loadingInstance = ref(null)

//表单元素
let form = ref(null)

//login仓库的state数据
const {
    // 权限列表
    authorityList,
    // 部门号
    departId,
} = storeToRefs(loginStore)

// layout仓库的state数据
const {
    // 主题
    theme
} = storeToRefs(layoutStore)

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

//表单数据
const FormData = ref({
})

//表单规则
const FormRules = reactive({
    departId: [{ required: true, message: '请选择部门', trigger: 'change' }],
    title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
    content: [{ required: true, message: '请输入内容', trigger: 'blur' }],
})


//是否可以向所有部门发送通知
const hasNoticeForAll = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === 'noticeForAll'
    })
    if (index === -1) {
        FormData.value.departId = departId.value
        return false
    } else {
        return true
    }
})

function resetForm() {
    form.value.resetFields()
}

// employees仓库的state数据
const {
    // 部门列表
    departmentList,
} = storeToRefs(employeesStore)

// employees仓库的action方法
const {
    //获取部门信息
    getDepartmentList,
} = employeesStore

const submitForm = async (formEl) => {
    if (!formEl) return
    await formEl.validate(async (valid, fields) => {
        if (valid) {
            if (hasNoticeForAll.value) {
                let departIdStr = FormData.value.departId.join(",")
                let form = {
                    departId: departIdStr,
                    title: FormData.value.title,
                    content: FormData.value.content,
                }
                //动画开始
                loadingInstance.value = ElLoading.service({ fullscreen: true })
                await notice.reqIssueNotice(form).then((resolve) => {
                    socket.emit("notice", "")
                    //提示信息
                    $ElMessage.success(resolve.message)
                    //动画结束
                    loadingInstance.value.close()
                })
            } else {
                let form = {
                    departId: FormData.value.departId,
                    title: FormData.value.title,
                    content: FormData.value.content,
                }
                //动画开始
                loadingInstance.value = ElLoading.service({ fullscreen: true })
                await notice.reqIssueNotice(form).then((resolve) => {
                    socket.emit("notice", "")
                    //提示信息
                    $ElMessage.success(resolve.message)
                    //动画结束
                    loadingInstance.value.close()
                })
            }
            resetForm()
        } else {
            console.log('请填写正确的内容')
        }
    })
}


//获取数据
const getData = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })
    //获取部门列表,获取公司职位类型
    await getDepartmentList().then((resolve) => {
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
:deep(.el-dialog__body) {
    padding-bottom: 0px !important;
}

:deep(.el-form-item__label) {
    height: 40px !important;
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
    // margin-right: 32px;
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
.noticeForm {
    backdrop-filter: blur(100px);
    padding: 20px;
    box-sizing: border-box;

    .feedback_main_light {
        width: 100%;

        :deep(.el-form-item__label) {
            font-size: 17px;
            color: #333 !important;
            user-select: none;
            width: 27%;
        }

        :deep(.el-form-item__content) {
            display: flex;
            justify-content: flex-start;
            width: 73%;
            margin-bottom: 20px;

            .input {
                width: 100%
            }

            .el-form-item__error {
                font-size: 14px;
            }
        }

    }

    .feedback_main_dark {
        width: 100%;

        :deep(.el-form-item__label) {
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
