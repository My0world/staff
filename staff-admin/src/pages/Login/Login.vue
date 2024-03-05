<template>
    <div class="Login">

        <!-- 登录 -->
        <div class="login_container"
            :style="{ boxShadow: themeType ? '0 0 30px 10px rgba(0, 0, 0, .3)' : '0 0 30px 10px rgba(255, 255, 255, .3)' }">
            <div class="login_title" :style="{ color: themeType ? '#333' : '#ebeaea' }">
                用户登录
                <ThemeSwitch class="switch"></ThemeSwitch>
            </div>
            <el-form ref="loginFormRef" :rules="loginFormRules"
                :class="{ login_main_light: themeType, login_main_dark: !themeType }" :model="loginForm">
                <el-form-item label="员工号:" class="form_item_30" prop="staffId">
                    <div class="input">
                        <el-input v-model="loginForm.staffId" type="text" placeholder="请输入员工号" />
                    </div>
                </el-form-item>
                <el-form-item label="密码:" class="form_item_50" prop="password">
                    <div class="input">
                        <el-input v-model="loginForm.password" type="password" placeholder="请输入密码" show-password />
                    </div>
                </el-form-item>
                <div class="btn_grup form_item_50">
                    <el-button :dark="true" type="primary" size="large" @click="loginSubmit(loginFormRef)"
                        class="login_btn">登录</el-button>
                    <el-button class="login_feedback" type="info" link text @click="showFeedbackDialog">反馈</el-button>
                </div>
            </el-form>
        </div>
        <Dialog class="feedbackDialog" ref="feedbackDialog" width="25%" top="15%">
            <template v-slot:header>
                <span :style="{ color: themeType ? '#333' : '#ebeaea' }">反馈</span>
            </template>

            <template v-slot:body>
                <el-form ref="feedbackFormRef" :rules="feedbackFormRules"
                    :class="{ feedback_main_light: themeType, feedback_main_dark: !themeType }" :model="feedbackForm">
                    <el-form-item label="员工号:" class="form_item_10" prop="staffId">
                        <div class="input">
                            <el-input v-model="feedbackForm.staffId" type="text" placeholder="请输入员工号" />
                        </div>
                    </el-form-item>
                    <el-form-item label="反馈内容:" class="form_item_50" prop="content">
                        <div class="input">
                            <el-input v-model="feedbackForm.content" minlength="5" maxlength="50" show-word-limit
                                resize="none" type="textarea" placeholder="请输入反馈内容" />
                        </div>
                    </el-form-item>
                </el-form>
            </template>

            <template v-slot:footer>
                <el-button size="large" @click="hideFeedbackDialog">取消</el-button>
                <el-button size="large" @click="feedbackSubmit(feedbackFormRef)" type="primary">确认</el-button>
            </template>
        </Dialog>
    </div>
</template>


<script setup>
import { reactive, computed, getCurrentInstance, ref } from "vue";
//防抖
import { debounce } from "lodash"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../stores/layout'
// 引入login仓库
import { useLoginStore } from '../../stores/login'
//引入路由
import { useRouter } from "vue-router";

// 使用路由
let router = useRouter()
// 获取layout仓库
const layoutStore = useLayoutStore()
// 获取login仓库
const loginStore = useLoginStore()
//获取全局挂载
let internalInstance = getCurrentInstance();

// layout仓库的state数据
const {
    // 主题
    theme
} = storeToRefs(layoutStore)

// login仓库的action方法
const {
    // 发送反馈信息表单
    sendFeedbackForm,
    // 发送登录信息表单
    sendLoginForm
} = loginStore

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

// 登录表单
const loginForm = reactive({
    staffId: "",
    password: ""
})

// 登录表单验证规则
const loginFormRules = reactive({
    staffId: [
        { required: true, message: '请输入员工号', trigger: 'blur' }
    ],
    password: [
        { required: true, message: '请输入密码', trigger: 'blur' }
    ],
})

//登录表单元素
let loginFormRef = ref(null)

//等待动画
let loadingInstance = ref(null)

// 登录提交
const loginSubmit = debounce(async (el) => {

    if (!el) return
    await el.validate(async (valid, fields) => {
        if (valid) {
            //动画开始
            loadingInstance.value = ElLoading.service({ fullscreen: true })
            await sendLoginForm(loginForm).then(resolve => {
                //动画结束
                loadingInstance.value.close()
                $ElMessage({
                    message: resolve,
                    type: "success"
                })
            }, reject => {
                //动画结束
                loadingInstance.value.close()
            })

            router.push({ path: "/" })
        } else {
            $ElMessage({
                message: "请输入员工号和密码",
                type: "error"
            })
        }
    })
}, 500)

// 对话框状态
let feedbackDialog = ref(null)

// 反馈表单
const feedbackForm = reactive({
    staffId: "",
    content: ""
})

// 反馈表单验证规则
const feedbackFormRules = reactive({
    staffId: [
        { required: true, message: '请输入员工号', trigger: 'blur' }
    ],
    content: [
        { required: true, message: '请输入反馈内容', trigger: 'blur' },
        { min: 5, max: 50, message: '长度应该在5-50个字', trigger: 'blur' },
    ],
})

// 反馈表单元素
let feedbackFormRef = ref(null)

// 显示反馈对话框
const showFeedbackDialog = debounce(() => {
    feedbackDialog.value.dialogStatus = true
    feedbackForm.staffId = ""
    feedbackForm.content = ""
}, 500)

//隐藏反馈对话框
const hideFeedbackDialog = () => {
    feedbackDialog.value.dialogStatus = false
}

//反馈提交
const feedbackSubmit = debounce(async (el) => {
    if (!el) return
    await el.validate(async (valid, fields) => {
        if (valid) {
            //动画开始
            loadingInstance.value = ElLoading.service({ fullscreen: true })
            await sendFeedbackForm(feedbackForm).then((result) => {
                //动画结束
                loadingInstance.value.close()
                $ElMessage({
                    message: result,
                    type: "success"
                })
            }).catch((err) => {
                //动画结束
                loadingInstance.value.close()
            });

        } else {
            $ElMessage({
                message: "请输入员工号和正确的反馈内容",
                type: "error"
            })
        }
    })
}, 500)


</script>


<style lang="less" scoped>
.Login {
    position: relative;
    width: 100%;
    height: 100vh;

    .form_item_10 {
        margin-top: 10px;
    }

    .form_item_30 {
        margin-top: 30px;
    }

    .form_item_50 {
        margin-top: 50px;
    }

    .login_container {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1;
        width: 20%;
        height: 350px;
        padding: 50px 50px 30px 50px;
        border-radius: 10px;
        backdrop-filter: blur(100px);
        display: flex;
        flex-direction: column;
        justify-content: space-between;

        .login_title {
            position: relative;
            width: 100%;
            height: 70px;
            font-size: 27px;
            font-weight: bold;

            .switch {
                position: absolute;
                top: 0;
                right: 0;
            }
        }

        .login_main_light {
            width: 100%;
            height: 400px;

            :deep(.el-form-item__label) {
                display: flex;
                justify-content: flex-start;
                font-size: 17px;
                color: #333 !important;
                user-select: none;
                width: 27%;
            }

            :deep(.el-form-item__content) {
                display: flex;
                justify-content: flex-end;
                width: 73%;


                .input {
                    width: 100%
                }

                .el-form-item__error {
                    font-size: 14px;
                    margin-top: 3px;
                }
            }


            .btn_grup {
                height: 70px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;

                .login_btn {
                    width: 99%;
                    font-size: 17px;
                }

                .login_feedback {
                    color: #333;
                    font-size: 15px !important;
                    text-decoration: underline !important;
                    margin: 0 !important;
                }

            }

        }

        .login_main_dark {
            width: 100%;
            height: 400px;

            :deep(.el-form-item__label) {
                display: flex;
                justify-content: flex-start;
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

            .btn_grup {
                height: 70px;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;

                .login_btn {
                    width: 99%;
                    font-size: 17px;
                }

                .login_feedback {
                    color: #ebeaea;
                    font-size: 15px !important;
                    text-decoration: underline !important;
                    margin: 0 !important;
                }

            }

        }

    }

    .feedbackDialog {
        span {
            font-size: 27px;
            font-weight: bold;
        }

        .feedback_main_light {
            width: 100%;

            :deep(.el-form-item__label) {
                display: flex;
                justify-content: flex-start;
                font-size: 17px;
                color: #333 !important;
                user-select: none;
                width: 27%;
            }

            :deep(.el-form-item__content) {
                display: flex;
                justify-content: flex-end;
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
                justify-content: flex-start;
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

        .el-textarea {
            height: 100px;

            :deep(.el-textarea__inner) {
                height: 100%;
            }
        }

        .el-button {
            font-size: 17px !important;
        }



    }


}
</style>
