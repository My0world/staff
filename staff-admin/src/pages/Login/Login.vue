<template>
    <div class="Login">
        <h1>登录</h1>
    </div>
</template>


<script setup>

import {onMounted } from "vue";



onMounted(() => {
    import("../../util/socket")
});
</script>


<style>
    .Login{
        
    }
</style>

