<template>
    <div class="borderCard">
        <p>
            <span :style="{color:theme === 'light' ? '#000' : '#fff'}">{{ mykey }}：</span>
            <span :style="{color:theme === 'light' ? '#000' : '#fff'}">{{ msg }}</span>
        </p>
    </div>
</template>


<script setup>
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 获取layout仓库
let layoutStore = useLayoutStore()

// layout仓库的state数据
const {
    // 主题
    theme,
} = storeToRefs(layoutStore)

const prop = defineProps(["mykey", "msg"])
</script>


<style lang="less" scoped>
.borderCard {
    border: 1px solid #eee;
    border-radius: 5px;
    padding: 14px;
    height: 42px;
    display: flex;
    align-items: center;
    backdrop-filter: blur(100px);
}
</style>
