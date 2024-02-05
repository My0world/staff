<template>
    <el-dialog :class="themeType ? 'light_dialog' : 'night_dialog'" v-model="dialogStatus" :modal="false" :width="width"
        @closed="closed" @open="open">
        <template #header>
            <slot name="header"></slot>
        </template>
        <slot name="body">

        </slot>
        <template #footer>
            <slot name="footer"></slot>
        </template>
    </el-dialog>
</template>


<script setup>
import { ref, computed } from 'vue';
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../stores/layout'
// 获取layout仓库
const layoutStore = useLayoutStore()


const emit = defineEmits(['handleOpen', 'handleClosed'])

// layout仓库的state数据
const {
    // 显示或隐藏的状态
    theme
} = storeToRefs(layoutStore)

//传值
const props = defineProps({
    //标题
    title: {
        type: String
    },
    //对话框宽度
    width: {
        type: String,
        default: "50%"
    },
})

//对话框关闭时
const closed = () => {
    emit("handleClosed")
}

//对话框打开时
const open = () => {
    emit("handleOpen")
}

//对话框显示与隐藏
let dialogStatus = ref(false)

//主题类型
const themeType = computed(() => {
    return theme.value === "light" ? true : false
})

//暴露数据
defineExpose({
    dialogStatus,
})


</script>


<style lang="less">
.light_dialog {
    backdrop-filter: blur(100px);
    background: transparent;
    z-index: 2;
    border-radius: 10px;
    box-shadow: 0 0 30px 10px rgba(0, 0, 0, .3);

    .el-dialog__headerbtn {
        font-size: 15px;

        i {
            color: #333 !important;
        }
    }

    .el-dialog__body {
        height: 100%;
    }
}

.night_dialog {

    backdrop-filter: blur(100px);
    background: transparent;
    z-index: 2;
    border-radius: 10px;
    box-shadow: 0 0 30px 10px rgba(255, 255, 255, .3);

    .el-dialog__headerbtn {
        i {
            color: #ebeaea !important;
        }
    }

    .el-dialog__body {
        height: 100%;
    }
}
</style>

