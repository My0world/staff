<template>
    <div class="list">
        <el-row :gutter="20" class="container">
            <el-col v-for="i in formatterList" :key="i.id" :span="6" class="item">
                <component :is='i.description' :data="i" :isAut="hasUpdateOpReviewStatus" :status="status"
                    :length="formatterList.length">
                </component>
            </el-col>
        </el-row>
        <div class="pagination" :class="theme">
            <el-pagination class="trans" v-model:current-page="pageNo" :page-size="10"
                layout=" jumper, total,->, prev, pager, next" :total="total" :background="true"
                @current-change="handleCurrentChange" />
        </div>

    </div>

</template>


<script>
import { onMounted, ref, computed, provide } from 'vue'
//更改请求组件
import updateRequest from "./updateRequest.vue"
//添加请求组件
import addRequest from "./addRequest.vue"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入操作请求审核仓库
import { useOperatingRequestStore } from '../../../stores/operatingRequest'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'


export default {
    name: "list",
    components: {
        updateRequest,
        addRequest
    },
    props: {
        status: {
            type: String,
            default: "待审核"
        }
    },
    setup(props) {

        // 页码
        let pageNo = ref(1)
        provide("pageNo", pageNo);

        // 使用layout仓库
        let layoutStore = useLayoutStore()

        // 使用operatingRequest仓库
        let operatingRequestStore = useOperatingRequestStore()

        // 使用login仓库
        let loginStore = useLoginStore()

        //等待动画
        let loadingInstance = ref(null)

        // 是否有更新操作请求内容状态权限
        const hasUpdateOpReviewStatus = computed(() => {
            let index = authorityList.value.findIndex((item) => {
                return item === "updateOpReviewStatus"
            })
            return index !== -1
        })

        // login仓库的state数据
        const {
            //权限列表
            authorityList,
        } = storeToRefs(loginStore)

        // layout仓库的state数据
        const {
            // 主题
            theme,
        } = storeToRefs(layoutStore)

        //operatingRequest仓库的state数据
        const {
            // 操作请求审核数据
            formatterList,
            // 操作请求审核数据总数
            total,
        } = storeToRefs(operatingRequestStore)

        //注入
        provide("length", formatterList.value.length);

        // operatingRequest仓库的action方法
        const {
            //获取操作请求审核数据
            getOpReviewData,
            //获取部门列表
            getDepartmentList
        } = operatingRequestStore

        // 获取数据
        const getData = async (status, pageNo) => {
            // 动画开始
            loadingInstance.value = ElLoading.service({ fullscreen: true })
            // 获取数据
            await Promise.all(getOpReviewData(status, pageNo), getDepartmentList()).then(reslove => {
                // 动画结束
                loadingInstance.value.close()
            }, reject => {
                // 动画结束
                loadingInstance.value.close()
            })
        }

        // 页码变化
        const handleCurrentChange = async (PNo) => {
            pageNo.value = PNo
            await getData(props.status, pageNo.value)
        }

        onMounted(async () => {
            await getData(props.status, pageNo.value)
        })

        return {
            //状态
            status: props.status,
            // 页码
            pageNo,
            // 数据总数
            total,
            // 操作请求审核数据
            formatterList,
            // 主题
            theme,
            // 页码变化
            handleCurrentChange,
            // 是否有更新操作请求内容状态权限
            hasUpdateOpReviewStatus
        }

    },

}
</script>


<style scoped lang="less">
.list {
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;

    .container {
        overflow-y: auto;
        height: calc(100% - 40px);
        padding: 10px;
        padding-bottom: 0px;
        box-sizing: border-box;

        .item {
            margin-bottom: 25px;
        }
    }

    .pagination {
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
        height: 50px;

        .trans {
            transform: translateY(-5px);
        }

    }
}

.light {
    border-top: 1px solid #333333;

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
    border-top: 1px solid #EBEAEA;

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
</style>
