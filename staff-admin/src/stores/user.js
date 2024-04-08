import {
    defineStore
} from "pinia"
import user from "../api/index"
// 格式化时间
export const useUserStore = defineStore("user", {
    state: () => ({
        // 用户信息搜索信息表单
        userForm: {
            status: "",
            departId: "",
            pageNo: 1
        },
        userList: [],//用户信息
        total: 0,//用户信息
        allAuthorityList: [] //权限数据
    }),
    getters: {
        //格式化表格
        formatterAuthorityData() {
            let Auths = []
            if (this.allAuthorityList) {
                this.allAuthorityList.forEach((item) => {
                    //一级
                    if (!item.two_level_name) {
                        Auths.push({ ...item, children: [] })
                        return
                    }
                })
                this.allAuthorityList.forEach((item) => {
                    //一级
                    if (!item.two_level_name) {
                        return
                    }
                    //二级
                    if (item.one_level_name && !item.three_level_name) {
                        let twoIndex = Auths.findIndex(citem => {
                            return citem.right_name == item.one_level_name
                        })
                        if (twoIndex !== -1) {
                            Auths[twoIndex].children.push({ ...item, children: [] })
                            return
                        }
                    }
                })
                this.allAuthorityList.forEach((item) => {
                    //一级
                    if (!item.two_level_name) {
                        return
                    }
                    //二级
                    if (item.one_level_name && !item.three_level_name) {
                        return
                    }
                    //三级
                    if (item.three_level_name) {
                        let twoIndex = Auths.findIndex(citem => {
                            return citem.right_name == item.one_level_name
                        })
                        if (twoIndex !== -1) {
                            let threeIndex = Auths[twoIndex].children.findIndex(citem => {
                                return citem.right_name == item.two_level_name
                            })
                            if (threeIndex !== -1) {
                                Auths[twoIndex].children[threeIndex].children.push({ ...item })
                                return
                            }
                        }
                    }
                })
            }
            return Auths
        }
    },
    actions: {

        //获取权限
        async getAuthorityData() {
            let res = await user.reqAuthorityData()
            res.data.data.forEach((item, index) => {
                res.data.data[index].disabled = false
            })
            this.allAuthorityList = res.data.data
        },

        //筛选用户信息
        async filterUserData(item) {
            let res = await user.reqUserData(item)
            this.userList = res.data.data
            this.total = res.data.total
        },

        //查看密码
        async getPassWord(item) {
            let res = await user.reqShowPassWord(item)
            let index = this.userList.findIndex(item=>{
                return res.data.staffId === item.staffId
            })
            this.userList[index].password = res.data.password
        }
    }
})