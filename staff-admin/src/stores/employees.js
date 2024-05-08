import {
    defineStore
} from "pinia"
import employees from "../api/index"
export const useEmployeesStore = defineStore("employees", {
    state: () => ({
        // 员工信息搜索信息表单
        employeesSearchForm: {
            departId: "",
            startEntryTime: "",
            endEntryTime: "",
            job: "",
            sex: "",
            startSalary: 0,
            endSalary: 0,
            startAge: 0,
            endAge: 0,
            searchValue: "",
            pageSize: 8,
            pageNo: 1
        },
        // 员工考勤搜索信息表单
        checkingInSearchForm: {
            departId: "",
            status: "",
            searchValue: "",
            dateTime: "",
            pageSize: 8,
            pageNo: 1,
        },
        // 员工请假搜索信息表单
        vacationSearchForm: {
            departId: "",
            status: "",
            dateTime: "",
            searchValue: "",
            staffId: "",
            pageSize: 8,
            pageNo: 1,
        },
        //考勤信息
        checkingInData: [],
        //请假历史记录
        askforleaveData: [],
        askforleaveTotal: 0,//请假记录总数
        checkingInTotal: 0,//考勤记录总数
        departmentList: [],//部门信息
        jobType: [],//职位类型
        staffList: [],//员工信息
        total: 0,//员工总数
    }),
    getters: {

    },
    actions: {
        //获取部门信息
        async getDepartmentList() {
            let res = await employees.reqDepartmentList()
            this.departmentList = res.data.data
        },

        //获取职位类型
        async getJobType() {
            let res = await employees.reqJobType()
            this.jobType = res.data
        },

        //筛选员工信息
        async filterStaffData(item) {
            let res = await employees.reqStaffData(item)
            this.staffList = res.data.data
            this.total = res.data.total
        },

        //筛选考勤数据
        async filterCheckingInData(item) {
            let res = await employees.reqCheckingInData(item)
            this.checkingInData = res.data.data
            this.checkingInTotal = res.data.total
        },

        //筛选请假数据
        async filterAskforleaveData(item) {
            console.log(123);
            let res = await employees.reqAskforleaveData(item)
            this.askforleaveData = res.data.data
            this.askforleaveTotal = res.data.total
        },
    }
})