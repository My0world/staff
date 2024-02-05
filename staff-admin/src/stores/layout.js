import {
	defineStore
} from "pinia"
import { setSession, getSession } from '../util/MySession'
export const useLayoutStore = defineStore("layout", {
	state: () => ({
		collapse: false, // 显示/隐藏的状态
		currentMenu: getSession("currentMenu") || null, // 当前路径
		tagList: getSession("tagList") || [{
			path: "/home",
			label: '首页'
		}],// 标签列表
		theme: "light" //主题颜色切换(light 浅色 | dark 深色)
	}),
	getters: {

	},
	actions: {
		// 设置显示/隐藏的状态
		setCollapse() {
			this.collapse = !this.collapse
		},
		// 切换路径事件的方法
		selectMenu(path, label) {
			//当前页面是首页
			if (path === '/home') {
				this.currentMenu = null
			} else {
				//不是首页时添加当前页
				this.currentMenu = label.split('|')
				//标签列表查找是否已经拥有当前的菜单
				let index = this.tagList.findIndex((item) => {
					return item.path === path
				})
				//标签列表没有当前的菜单就添加,并且添加颜色
				if (index === -1) {
					this.tagList.push({
						path, label
					})
				}
			}
			//持久化保存
			setSession("currentMenu", this.currentMenu)
			setSession("tagList", this.tagList)
		},
		// 删除标签
		deleteTag(path) {
			//查找要删除的那项
			let index = this.tagList.findIndex((item) => {
				return item.path === path
			})
			//删除
			this.tagList.splice(index, 1)
			//持久化保存
			setSession("tagList", this.tagList)
		},
		// 切换主题颜色
		setTheme() {
			if (this.theme == "light") {
				this.theme = "dark"
			} else {
				this.theme = "light"
			}
		},
	}
})