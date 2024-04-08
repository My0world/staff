<template>
    <Card class="table" title="操作记录" :theme="theme">
        <template v-slot:body>
            <div class="UserTable" :class="[theme === 'light' ? 'light' : 'dark']">
                <div class="operation">
                    <el-button type="primary" size="large" :disabled="!hasAddAdminUser">添加用户</el-button>
                    <el-button link type="primary" size="large">您有新的内容可刷新</el-button>
                </div>
                <el-table :data="userList" style="width: 100%;margin: 10px 0px; height:calc(100% - 100px) ;" border>
                    <el-table-column :resizable="false" prop="departName" label="部门名称" min-width="50" />
                    <el-table-column :resizable="false" prop="staffId" label="员工号" min-width="45" />
                    <el-table-column :resizable="false" prop="staffName" label="姓名" min-width="50" />
                    <el-table-column :resizable="false" prop="password" label="密码" min-width="50">
                        <template #default="scope">
                            <span v-if="scope.row.password === 'none' && hasShowUserPassWord">
                                <el-button type="primary" @click="showPassword(scope.row)" link>查看密码</el-button>
                            </span>
                            <div class="editPassword" v-else>
                                <span>{{ scope.row.password }}</span>
                                <el-button type="info" size="small" :disabled="!hasUpdateUserPassWord" @click="editPassword(scope.row)">修改密码</el-button>
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="status" label="用户状态" min-width="50" />
                    <el-table-column :resizable="false" fixed="right" label="操作栏">

                        <template #default="scope">
                            <el-button size="small" type="warning" v-if="hasAllotAuthority" @click="handleAllot(scope.row)">分配权限</el-button>
                            <el-button size="small" type="danger" v-if="hasDeleteUser" @click="handleDelUser(scope.row)">删除用户</el-button>
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination v-model:current-page="userForm.pageNo" :page-size="12"
                    layout=" jumper, total,->, prev, pager, next," :total="total" :background="true"
                    @current-change="handleCurrentChange" />
            </div>
        </template>
    </Card>

    <el-drawer v-model="drawer" title="分配权限">
        <AuthDrawer ref="drawerRef" v-if="drawer" :auth="authData"></AuthDrawer>
        <template #footer>
            <div style="flex: auto">
                <el-button @click="drawer = !drawer">取消</el-button>
                <el-button type="primary" @click="confirmClick">确认</el-button>
            </div>
        </template>
    </el-drawer>

    <Dialog @handleOpen="handleEditOpen" class="editDialog" ref="editDialog" width="25%" top="15%">
        <template v-slot:header>
            <span :style="{ color: themeType ? '#333' : '#ebeaea' }">修改密码</span>
        </template>
        <template v-slot:body>
            <el-form :class="{ feedback_main_light: themeType, feedback_main_dark: !themeType }" ref="editRef"
                :model="editForm" :rules="editrules">
                <el-form-item style="margin-bottom: 35px;" label="员工号" label-width='120px' prop="staffId">
                    <el-input placeholder="请输入员工号" :disabled="true" v-model="editForm.staffId"></el-input>
                </el-form-item>
                <el-form-item style="margin-bottom: 35px;" label="密码" label-width='120px' prop="password">
                    <el-input placeholder="请输入密码" v-model="editForm.password"></el-input>
                </el-form-item>
                <el-form-item label="确认密码" label-width='120px' prop="repassword">
                    <el-input placeholder="请再次输入密码" v-model="editForm.repassword"></el-input>
                </el-form-item>
            </el-form>
        </template>
        <template v-slot:footer>
            <el-button @click="editDialog.dialogStatus = false"><el-icon class="el-icon--right">
                    <CloseBold />
                </el-icon> 取消</el-button>
            <el-button type="primary" @click="editPasswordSubmit(editRef)"> <el-icon class="el-icon--right">
                    <Select />
                </el-icon> 确认 </el-button>
        </template>
    </Dialog>

    <Dialog @handleOpen="handlePassWordOpen" :modal="true" class="PassWordDialog" ref="PassWordDialog" width="15%"
        top="15%">
        <template v-slot:header>
            <span :style="{ color: '#ebeaea' }">输入密码</span>
        </template>
        <template v-slot:body>
            <el-input v-model="requireUserPassword" type="password" placeholder="请输入密码" show-password />
        </template>
        <template v-slot:footer>
            <el-button @click="PassWordDialog.dialogStatus = false"><el-icon class="el-icon--right">
                    <CloseBold />
                </el-icon> 取消</el-button>
            <el-button type="primary" @click="handleCommit"> <el-icon class="el-icon--right">
                    <Select />
                </el-icon> 确认 </el-button>
        </template>
    </Dialog>

</template>


<script setup>
import { ref, computed, onMounted, getCurrentInstance, reactive } from 'vue';
import AuthDrawer from './AuthDrawer.vue'
//API
import user from '../../../api'
// 格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入user仓库
import { useUserStore } from '../../../stores/user'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'

//获取全局挂载
let internalInstance = getCurrentInstance();

//获取全局Element消息提示框
let $ElMessage = internalInstance.appContext.config.globalProperties.$ElMessage;

//抽屉
let drawer = ref(false)

//抽屉元素
let drawerRef = ref(null)

//权限数据
let authData = ref("")

// 使用login仓库
let loginStore = useLoginStore()

// 使用layout仓库
let layoutStore = useLayoutStore()

// 输入密码执行后的操作（1：添加，2：查看密码：3：修改密码，4：分配权限，5：删除用户）
let type = ref("")

// 使用user仓库
let userStore = useUserStore()

// 输入密码对话框
let PassWordDialog = ref(null)

//输入密码
let requireUserPassword = ref("")

// 修改的用户
let updateStaffId = ref("")

//权限字符串
let authorityString = ref("")

//等待动画
let loadingInstance = ref(null)

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

// user仓库的state数据
const {
    //用户信息
    userList,
    //用户信息总数
    total,
    // 用户信息搜索信息表单
    userForm
} = storeToRefs(userStore)

// login仓库的state数据
const {
    //权限
    authorityList
} = storeToRefs(loginStore)

// 是否有添加用户的权限
const hasAddAdminUser = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "addAdminUser"
    })
    return index !== -1
})

// 是否有删除用户的权限
const hasDeleteUser = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "deleteUser"
    })
    return index !== -1
})

// 是否有查看某位用户的密码的权限
const hasShowUserPassWord = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "showUserPassWord"
    })
    return index !== -1
})

// 是否有修改某位用户的密码的权限
const hasUpdateUserPassWord = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "updateUserPassWord"
    })
    return index !== -1
})

// 是否有分配权限的权限
const hasAllotAuthority = computed(() => {
    let index = authorityList.value.findIndex((item) => {
        return item === "allotAuthority"
    })
    return index !== -1
})

// user仓库的action方法
const {
    //筛选用户信息
    filterUserData,
    //查看用户密码
    getPassWord
} = userStore

//修改密码
const editForm = reactive({
    staffId: "",
    password: "",
    repassword: ""
})

//修改密码对话框
let editRef = ref(null)

//两个密码是否一致
let validateEditPass = (rule, value, callback) => {
    if (value === '') {
        callback(new Error('请再次输入密码'))
    } else if (value !== editForm.password) {
        callback(new Error('两次输入密码不一致!'))
    } else {
        callback()
    }
}

//修改密码校验规则
const editrules = reactive({
    staffId: [
        { required: true, message: '请输入员工号', trigger: 'blur' }
    ],
    password: [
        { required: true, message: '请输入密码', trigger: 'blur' }
    ],
    repassword: [
        { required: true, validator: validateEditPass, trigger: 'blur' }
    ]
})

//获取权限同时渲染权限树
const handleAllot = (row) => {
    drawer.value = true
    authData.value = row.authority
    updateStaffId.value = row.staffId
}

//获取数据
const getData = async () => {
    //动画开始
    loadingInstance.value = ElLoading.service({ fullscreen: true })

    await filterUserData(userForm.value).then((resolve) => {
        //动画结束
        loadingInstance.value.close()
    }).catch(() => {
        //动画结束
        loadingInstance.value.close()
    })
}

//页码变化
const handleCurrentChange = async (pageNo) => {
    userForm.value.pageNo = pageNo
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

//执行操作
const handleCommit = async () => {
    // 查看密码
    if (type.value == 2) {
        let obj = {
            staffId: updateStaffId.value,
            requireUserPassword: requireUserPassword.value,
        }
        //动画开始
        loadingInstance.value = ElLoading.service({ fullscreen: true })
        await getPassWord(obj).then(async (resolve) => {
            //密码对话框
            PassWordDialog.value.dialogStatus = false
            //重置数据
            requireUserPassword.value = ""
            updateStaffId.value = ""
            loadingInstance.value.close()
        }).catch(() => {
            //动画结束
            loadingInstance.value.close()
        })
    }
    // 修改密码
    if (type.value == 3) {
        let obj = {
            staffId: editForm.staffId,
            password: editForm.password,
            requireUserPassword: requireUserPassword.value,
        }
        // 动画开始
        loadingInstance.value = ElLoading.service({ fullscreen: true })
        await user.reqUpdatePassWord(obj).then(async (resolve) => {
            //提示信息
            $ElMessage.success(resolve.message)
            //密码对话框
            PassWordDialog.value.dialogStatus = false
            //修改密码对话框
            editDialog.value.dialogStatus = false
            //重置数据
            editForm.staffId = ""
            editForm.password = ""
            editForm.repassword = ""
            requireUserPassword.value = ""
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
        return
    }
    // 分配权限
    if (type.value == 4) {
        let obj = {
            staffId: updateStaffId.value,
            requireUserPassword: requireUserPassword.value,
            authorityString: authorityString.value
        }
        await user.reqAllotAuthority(obj).then(async (resolve) => {
            //提示信息
            $ElMessage.success(resolve.message)
            //密码对话框
            PassWordDialog.value.dialogStatus = false
            //重置数据
            authorityString.value = ""
            requireUserPassword.value = ""
            updateStaffId.value = ""
            drawer.value = false
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
        return
    }
    // 删除用户
    if (type.value == 5) {
        let obj = {
            staffId: updateStaffId.value,
            requireUserPassword: requireUserPassword.value,
        }
        await user.reqDeleteUser(obj).then(async (resolve) => {
            //提示信息
            $ElMessage.success(resolve.message)
            //密码对话框
            PassWordDialog.value.dialogStatus = false
            //重置数据
            requireUserPassword.value = ""
            updateStaffId.value = ""
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
        return
    }
}

//查看密码
const showPassword = (row) => {
    updateStaffId.value = row.staffId
    type.value = 2
    PassWordDialog.value.dialogStatus = true
}

//修改密码对话框
let editDialog = ref(null)

//打开修改密码对话框
const editPassword = (row) => {
    editForm.staffId = row.staffId
    editDialog.value.dialogStatus = true
}

//提交修改密码
const editPasswordSubmit = (el) => {
    if (!el) return
    el.validate((valid, fields) => {
        if (valid) {
            PassWordDialog.value.dialogStatus = true
            type.value = 3
        } else {
            $ElMessage.error("请输入正确的内容")
        }
    })
}

//判定权限是否合格
const confirmClick = () => {
    let list = drawerRef.value.getCheckedAuthData()

    //添加员工
    let hasAdminAddStaff = list.findIndex(item => {
        return item.right_name === "adminAddStaff"
    })
    let hasUserAddStaff = list.findIndex(item => {
        return item.right_name === "userAddStaff"
    })
    if (hasAdminAddStaff != -1 && hasUserAddStaff != -1) {
        $ElMessage.error("添加员工(无需审核)和添加员工(需审核)不可同时拥有")
        return
    }

    //修改员工、设置为离职员工
    let hasAdminUpdateStaff = list.findIndex(item => {
        return item.right_name === "adminUpdateStaff"
    })
    let hasUserUpdateStaff = list.findIndex(item => {
        return item.right_name === "userUpdateStaff"
    })
    let hasSettingDimission = list.findIndex(item => {
        return item.right_name === "settingDimission"
    })
    if (hasAdminUpdateStaff != -1 && hasUserUpdateStaff != -1) {
        $ElMessage.error("修改员工(无需审核)和修改员工(需审核)不可同时拥有")
        return
    }
    if (hasAdminUpdateStaff != -1 || hasUserUpdateStaff != -1 || hasSettingDimission != -1) {
        let index = list.findIndex(item => {
            return item.right_name === "allStaffMsgView" || item.right_name === "departmentStaffMsg"
        })
        if (index === -1) {
            $ElMessage.error("修改员工和设置为离职员工前必须要查看员工")
            return
        }
    }

    //查看员工
    let hasAllStaffMsgView = list.findIndex(item => {
        return item.right_name === "allStaffMsgView"
    })
    let hasDepartmentStaffMsg = list.findIndex(item => {
        return item.right_name === "departmentStaffMsg"
    })
    if (hasAllStaffMsgView != -1 && hasDepartmentStaffMsg != -1) {
        $ElMessage.error("所有员工信息和只可以查看自己部门的员工信息不可同时拥有")
        return
    }

    //用户
    let hasDeleteUser = list.findIndex(item => {
        return item.right_name === "deleteUser"
    })
    let hasAllotAuthority = list.findIndex(item => {
        return item.right_name === "allotAuthority"
    })
    let hasShowUserPassWord = list.findIndex(item => {
        return item.right_name === "showUserPassWord"
    })
    let hasUpdateUserPassWord = list.findIndex(item => {
        return item.right_name === "updateUserPassWord"
    })
    if (hasDeleteUser != -1 || hasAllotAuthority != -1 || hasShowUserPassWord != -1 || hasUpdateUserPassWord != -1) {
        let index = list.findIndex(item => {
            return item.right_name === "userData"
        })
        if (index === -1) {
            $ElMessage.error("分配权限、删除用户、查看用户密码和修改用户密码之前必须可以查看用户数据")
            return
        }
    }
    if (hasUpdateUserPassWord != -1) {
        let index = list.findIndex(item => {
            return item.right_name === "showUserPassWord"
        })
        if (index === -1) {
            $ElMessage.error("修改用户密码前必须可以查看用户密码")
            return
        }
    }

    //操作请求更改
    let hasUpdateOpReviewStatus = list.findIndex(item => {
        return item.right_name === "updateOpReviewStatus"
    })
    if (hasUpdateOpReviewStatus != -1) {
        let index = list.findIndex(item => {
            return item.right_name === "operatingRequestAuditData"
        })
        if (index === -1) {
            $ElMessage.error("审核操作的内容前必须可以查看操作请求的数据")
            return
        }
    }
    if (hasUserUpdateStaff != -1 && hasUserAddStaff != -1) {
        let index = list.findIndex(item => {
            return item.right_name === "updateOpReviewStatus"
        })
        if (index !== -1) {
            $ElMessage.error("该用户有需要被审核的操作")
            return
        }
    }




    //更改离职申请状态
    let hasUpdateResignReviewStatus = list.findIndex(item => {
        return item.right_name === "updateResignReviewStatus"
    })
    if (hasUpdateResignReviewStatus != -1) {
        let index = list.findIndex(item => {
            return item.right_name === "dimissionAudit"
        })
        if (index === -1) {
            $ElMessage.error("审核离职申请前必须可以查看到离职申请的数据")
            return
        }
    }

    //更改离职员工为正式员工
    let hasReturnStaffTable = list.findIndex(item => {
        return item.right_name === "returnStaffTable"
    })
    if (hasReturnStaffTable != -1) {
        let index = list.findIndex(item => {
            return item.right_name === "dimissionData"
        })
        if (index === -1) {
            $ElMessage.error("从离职员工表移回员工表前必须可以查看到离职员工的数据")
            return
        }
    }

    //权限字符串
    authorityString.value = ""
    list.forEach((element, index) => {
        if (index < list.length - 1) {
            authorityString.value += element.right_name + ","
        } else {
            authorityString.value += element.right_name
        }
    });

    //输入密码
    type.value = 4
    PassWordDialog.value.dialogStatus = true
}

//删除用户前
const handleDelUser = (row) => {
    updateStaffId.value = row.staffId
    PassWordDialog.value.dialogStatus = true
    type.value = 5
}

//打开修改密码窗口前
const handleEditOpen = () => {
    editForm.password = ""
    editForm.repassword = ""
}

//打开修改密码窗口前
const handlePassWordOpen = () => {
    requireUserPassword.value = ""
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
.el-drawer__title {
    font-size: 16px
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

    .UserTable {
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        box-sizing: border-box;

        .editPassword {
            display: flex;
            border: 1px solid #fff;
            border-radius: 3px;

            span:nth-of-type(1) {
                padding: 0px 7px;
                line-height: 30px;
                text-align: left;
                display: block;
                width: 100%
            }

            :deep(.el-button--small) {
                border-top-left-radius: 0px;
                border-bottom-left-radius: 0px;
                background: #fff;
                color: #333333;
                border: none;
                width: 57px;
                padding: 5px;
                height: auto !important;
                line-height: unset !important;
            }
        }

        .light {}

        .dark {}
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

<style scoped lang="less">
.editDialog {
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
