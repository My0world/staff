import {
    defineStore
} from "pinia"
import operatingData from "../api/index"
export const useOperatingDataStore = defineStore("operatingData", {
    state: () => ({
        // 员工信息搜索信息表单
        operatingDataForm: {
            startTime: "",
            endTime:"",
            searchText:"",
            pageNo:1
        },
        operatingList: [],//员工信息
        total: 0,//员工总数
    }),
    getters: {

    },
    actions: {
        //筛选员工信息
        async filterOperatingData(item) {
            let res = await operatingData.reqOperatingData(item)
            this.operatingList = res.data.data
            this.total = res.data.total
        }
    }
})