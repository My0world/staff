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
            startTime: "",
            searchValue: "",
            pageSize: 8,
            pageNo: 1,
        },
        //考勤信息
        checkingInData: [
            {
                staffId: "022404",
                staffName: "菲谢尔·冯·露弗施洛斯·那菲多特",
                date: "2024-04-12",
                startTime: "09:17:15",
                endTime: "18:00:59",
                status: "正常",
            },
            {
                staffId: "022403",
                staffName: "荧",
                date: "2024-04-12",
                startTime: "09:36:55",
                endTime: "18:00:59",
                status: "迟到",
            },
            {
                staffId: "042301",
                staffName: "钟离",
                date: "2024-04-12",
                startTime: "09:17:15",
                endTime: "18:00:59",
                status: "正常",
            },
            {
                staffId: "052301",
                staffName: "夜阑",
                date: "2024-04-12",
                startTime: "09:17:15",
                endTime: "18:00:59",
                status: "正常",
            },
            {
                staffId: "052303",
                staffName: "阿斯托洛吉斯·莫娜·梅姬斯图斯",
                date: "2024-04-12",
                startTime: "09:29:15",
                endTime: "18:22:59",
                status: "正常",
            },
            {
                staffId: "052304",
                staffName: "久岐忍",
                date: "2024-04-12",
                startTime: "09:29:15",
                endTime: "18:15:59",
                status: "正常",
            },
            {
                staffId: "012302",
                staffName: "枫原万叶",
                date: "2024-04-12",
                startTime: "09:29:15",
                endTime: "18:22:59",
                status: "正常",
            },
            {
                staffId: "012303",
                staffName: "卯香菱",
                date: "2024-04-12",
                startTime: "09:10:15",
                endTime: "18:15:59",
                status: "正常",
            },
        ],
        //请假历史记录
        askforleaveData: [
            {
                id: "1",
                staffName: "菲谢尔·冯·露弗施洛斯·那菲多特",
                staffId: "022404",
                departId: "01",
                content: "发烧，39度",
                startTime: "2024-04-11",
                endTime: "2024-04-19",
                dateTime: "2024-04-11",
                status: "审核通过"
            }, {
                id: "2",
                staffName: "荧",
                staffId: "022403",
                departId: "01",
                content: "肠胃炎",
                startTime: "2024-04-11",
                endTime: "2024-04-19",
                dateTime: "2024-04-11",
                status: "审核通过"
            }, {
                id: "3",
                staffName: "钟离",
                staffId: "042301",
                departId: "01",
                content: "姐姐结婚，需要回家",
                startTime: "2024-04-07",
                endTime: "2024-04-09",
                dateTime: "2024-04-01",
                status: "审核通过"
            }, {
                id: "4",
                staffName: "夜阑",
                staffId: "052301",
                departId: "01",
                content: "加班5个小时，需要放松",
                startTime: "2024-04-10",
                endTime: "2024-04-11",
                dateTime: "2024-04-09",
                status: "审核驳回"
            }, {
                id: "5",
                staffName: "阿斯托洛吉斯·莫娜·梅姬斯图斯",
                staffId: "052303",
                departId: "01",
                content: "雅思考试",
                startTime: "2024-04-11",
                endTime: "2024-04-19",
                dateTime: "2024-04-11",
                status: "审核通过"
            },
            {
                id: "6",
                staffName: "卯香菱",
                staffId: "012303",
                departId: "01",
                content: "劳动节没买到票提前回家",
                startTime: "2024-04-29",
                endTime: "2024-05-05",
                dateTime: "2024-04-11",
                status: "待审核"
            },
        ],
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
        },

        //筛选请假数据
        async filterAskforleaveData(item) {
        },
    }
})