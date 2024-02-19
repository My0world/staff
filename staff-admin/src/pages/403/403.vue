<template>
    <div class="NotFound">
        <n-result class="content" status="403" title="403 权限不足" description="没有权限哦" size="huge">
            <template #icon>
                <el-image class="iconImg" :src="userIcon('403', 'png')" fit="contain" />
            </template>
            <template #footer>
                <n-button @click="goHome">要不回到上一级？！</n-button>
            </template>
        </n-result>
    </div>
</template>


<script setup>
import { NResult, NButton } from 'naive-ui'
import imageSrc from "../../util/imageSrc"
import { useRouter } from 'vue-router'

let router = useRouter()

// 图片处理（函数）
let userIcon = imageSrc

const goHome = () => {
    router.go(-2)
}
</script>


<style lang="less" scoped>
.NotFound {
    height: 100vh;
    background: #ebeaea;
    display: flex;
    justify-content: center;
    align-items: center;

    .content {
        .iconImg {
            width: 256px;
            height: 256px;
        }
    }

}
</style>

