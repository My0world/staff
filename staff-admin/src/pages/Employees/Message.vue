<template>
    <div class="Message">
        <h1>信息管理</h1>
    </div>
</template>


<script setup>
import socket from '../../util/socket';
import { onMounted } from "vue";
onMounted(() => {
    socket.emit('sendNotice', "发送信息")
});

</script>


<style>
.Message {}
</style>

