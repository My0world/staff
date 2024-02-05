<template>
    <div class="StaffMsg">
        <SearchCard style="height: 28%;"></SearchCard>
        <StaffMsgTable style="height: 77%;"></StaffMsgTable>
    </div>
</template>


<script setup>
import SearchCard from './components/SearchCard.vue';
import StaffMsgTable from './components/StaffMsgTable.vue';


</script>


<style scoped lang="less">
.StaffMsg {
    margin-top: 17px;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
}
</style>

