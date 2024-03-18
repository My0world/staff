import {
    defineStore
} from "pinia"
import feedback from "../api/index"
export const useFeedbackStore = defineStore("feedback", {
    state: () => ({
        // 员工信息搜索信息表单
        feedbackForm: {
            startTime: "",
            endTime:"",
            searchText:"",
            pageNo:1
        },
        feedbackList: [],//员工信息
        total: 0,//员工总数
    }),
    getters: {

    },
    actions: {
        //筛选员工信息
        async filterFeedbackData(item) {
            let res = await feedback.reqFeedbackData(item)
            this.feedbackList = res.data.data
            this.total = res.data.total
        }
    }
})