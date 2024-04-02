<template>
    <Card class="table" title="操作记录" :theme="theme">
        <template v-slot:body>
            <div class="UserTable" :class="[theme === 'light' ? 'light' : 'dark']">
                <div class="operation">
                    <el-button type="primary" size="large">添加用户</el-button>
                    <el-button link type="primary" size="large">您有新的内容可刷新</el-button>
                </div>
                <el-table :data="userList" style="width: 100%;margin: 10px 0px; height:calc(100% - 100px) ;" border>
                    <el-table-column :resizable="false" prop="departName" label="部门名称" min-width="50" />
                    <el-table-column :resizable="false" prop="staffId" label="员工号" min-width="45" />
                    <el-table-column :resizable="false" prop="staffName" label="姓名" min-width="50" />
                    <el-table-column :resizable="false" prop="password" label="密码" min-width="50">
                        <template #default="scope">
                            <span v-if="scope.row.password === 'none'">
                                <el-button type="primary" link>查看密码</el-button>
                            </span>
                            <div class="editPassword" v-else>
                                <span>{{ scope.row.password }}</span>
                                <el-button type="info" size="small">修改密码</el-button>
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column :resizable="false" prop="status" label="用户状态" min-width="50" />
                    <el-table-column :resizable="false" fixed="right" label="操作栏">

                        <template #default="scope">
                            <el-button size="small" type="warning" @click="handleAllot(scope.row)">分配权限</el-button>
                            <el-button size="small" type="danger">删除用户</el-button>
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
        <AuthDrawer :auth="authData"></AuthDrawer>
    </el-drawer>

</template>


<script setup>
import { ref, computed, onMounted } from 'vue';
import AuthDrawer from './AuthDrawer.vue'
// 格式化时间
import { GMTToStr } from "../../../util/GMTToStr.js"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入operatingData仓库
import { useUserStore } from '../../../stores/user'

//抽屉
let drawer = ref(false)

//权限数据
let authData = ref("")

// 使用layout仓库
let layoutStore = useLayoutStore()

// 使用operatingData仓库
let userStore = useUserStore()

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
    userList,
    //操作记录总数
    total,
    // 操作记录信息搜索信息表单
    userForm
} = storeToRefs(userStore)


// operatingData仓库的action方法
const {
    //筛选操作记录信息
    filterUserData,
} = userStore

const handleAllot = (row) => {
    drawer.value = true
    authData.value = row.authority
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
.el-drawer__title{
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
