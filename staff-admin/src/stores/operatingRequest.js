import {
    defineStore
} from "pinia"
// 格式化时间
import { GMTToStr } from "../util/GMTToStr.js"
import operatingRequest from "../api/index"
import employees from "../api/index"
export const useOperatingRequestStore = defineStore("operatingRequest", {
    state: () => ({
        //操作请求审核数据
        list: [],
        //操作请求审核数据总数
        total: 0,
        //部门数据
        departmentList: []
    }),
    getters: {
        //格式化表格
        formatterList() {
            let resetlist = []
            this.list.forEach(element => {
                if (element.description === "updateRequest") {
                    let { id, data, datetime, description, staffId, staffName, status } = element
                    let formatterData = JSON.parse(data)
                    //修改后的部门ID
                    let nindex = this.departmentList.findIndex(item => {
                        return item.departId === formatterData.newData.departId
                    })
                    formatterData.newData.department_Name = this.departmentList[nindex].department_Name
                    //修改前的部门ID
                    let Oindex = this.departmentList.findIndex(item => {
                        return item.departId === formatterData.oldData.departId
                    })
                    formatterData.oldData.department_Name = this.departmentList[Oindex].department_Name
                    //放到数组中
                    resetlist.push({ id, data: formatterData, datetime: GMTToStr(datetime), description, staffId, staffName, status })
                }
                if (element.description === "addRequest") {
                    let { id, data, datetime, description, staffId, staffName, status } = element
                    let formatterData = JSON.parse(data)
                    //添加的部门ID
                    let index = this.departmentList.findIndex(item => {
                        return item.departId === formatterData.departId
                    })
                    formatterData.department_Name = this.departmentList[index].department_Name

                    resetlist.push({ id, data: formatterData, datetime: GMTToStr(datetime), description, staffId, staffName, status })
                }

            });
            return resetlist
        }
    },
    actions: {
        //获取操作请求审核数据
        async getOpReviewData(status, pageNo) {
            let res = await operatingRequest.reqOpReviewData(status, pageNo)
            this.list = res.data.data
            this.total = res.data.total
        },
        //获取部门信息
        async getDepartmentList() {
            let res = await employees.reqDepartmentList()
            this.departmentList = res.data.data
        },
    }
})