import {
    defineStore
} from "pinia"
// 格式化时间
import dimission from "../api/index"
export const useDimissionStore = defineStore("dimission", {
    state: () => ({
        // 审核离职员工数据
        auditList: [],
        // 审核离职员工数据总数
        auditTotal: 0,
        // 审核信息搜索信息表单
        dimissionSearchForm: {
            departId: "",
            job: "",
            sex: "",
            startResignTime: "",
            endResignTime: "",
            startAge: 0,
            endAge: 0,
            searchValue: "",
            pageSize: 8,
            pageNo: 1
        },
        // 离职员工数据
        dimissionList: [],
        // 离职员工数据总数
        dimissionTotal: 0,
    }),
    getters: {
    },
    actions: {
        //获取审核离职员工数据
        async getAuditListData(status, pageNo) {
            let res = await dimission.reqDimissionAuditData(status, pageNo)
            this.auditList = res.data.data
            this.auditTotal = res.data.total
        },
        //获取离职员工数据
        async filterDimissionListData(status, pageNo) {
            let res = await dimission.reqDimissionData(status, pageNo)
            this.dimissionList = res.data.data
            this.dimissionTotal = res.data.total
        },
    }
})