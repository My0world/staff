import {
    defineStore
} from "pinia"
import notice from "../api/index"
export const useNoticeStore = defineStore("noticeData", {
    state: () => ({
        // 已发送通知信息搜索信息表单
        sendForm: {
            searchText: "",
            pageNo: 1
        },
        //已发送通知信息
        sendList: [],
        //已发送通知总数
        sendTotal: 0,
        // 已接收通知信息搜索信息表单
        receiveForm: {
            searchText: "",
            pageNo: 1
        },
        //已接收通知信息
        receiveList: [],
        //已接收通知总数
        receiveTotal: 0,
    }),
    getters: {

    },
    actions: {
        //筛选已发送通知信息
        async filterSendData(item) {
            let res = await notice.reqSendData(item)
            this.sendList = res.data.data
            this.total = res.data.total
        },
        //筛选已接收通知信息
        async filterReceiveData(item) {
            console.log(123);
            let res = await notice.reqReceiverData(item)
            this.receiveList = res.data.data
            this.total = res.data.total
        }
    }
})