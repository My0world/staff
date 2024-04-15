import {
    defineStore
} from "pinia"
export const useNoticeStore = defineStore("noticeData", {
    state: () => ({
        // 已发送通知信息搜索信息表单
        sendForm: {
            searchText: "",
            pageNo: 1
        },
        //已发送通知信息
        sendList: [
            {
                departName: "管理层,开发部,测试部,人力资源,运维部",
                title: "重要通知：4月13日8点到4月15日18点后台系统关闭",
                datetime: "2024-4-10",
                content: "后台系统需要对通知管理，首页，请假管理3个功能模块就行升级和优化。",
                send_staffName: "艾吉奥·奥迪托雷·达·佛罗伦萨"
            },
        ],
        //已发送通知总数
        sendTotal: 0,
        // 已接收通知信息搜索信息表单
        receiveForm: {
            searchText: "",
            pageNo: 1
        },
        //已接收通知信息
        receiveList: [
            {
                departName: "管理层,开发部,测试部,人力资源,运维部",
                title: "重要通知：4月13日8点到4月15日18点后台系统关闭",
                datetime: "2024-4-10",
                content: "后台系统需要对通知管理，首页，请假管理3个功能模块就行升级和优化。",
                send_staffName: "艾吉奥·奥迪托雷·达·佛罗伦萨"
            },
        ],
        //已接收通知总数
        receiveTotal: 0,
    }),
    getters: {

    },
    actions: {
        //筛选已发送通知信息
        async filterSendData(item) {
        },
        //筛选已接收通知信息
        async filterReceiveData(item) {
        }
    }
})