<template>
    <div class="Card"
        :style="{ boxShadow: theme === 'light' ? '0 0 5px 3px rgba(0, 0, 0, .3)' : '0 0 5px 3px rgba(255, 255, 255, .3)' }">
        <div v-if="title" class="header" :style="{ color: theme === 'light' ? '#333333' : '#EBEAEA' }">
            {{ title }}
        </div>
        <div v-else class="header" :style="{ color: theme === 'light' ? '#333333' : '#EBEAEA' }">
            <slot name="title"></slot>
        </div>
        <div class="body">
            <slot name="body"></slot>
        </div>
    </div>
</template>


<script setup>
const prop = defineProps(["title", "theme"])

</script>


<style scoped lang="less">
.Card {
    width: 100%;
    height: 100%;
    backdrop-filter: blur(100px);
    display: flex;
    flex-direction: column;

    .header {
        width: 100%;
        font-size: 17px;
        padding: 14px;
        box-sizing: border-box;
    }

    .body {
        width: 100%;
        height: 100%;
        padding: 0 14px 14px 14px;
        box-sizing: border-box;
    }
}
</style>
