<template>
    <Card class="echart_wrap" :theme="theme">
        <template v-slot:title>
            <div class="title">
                <div :style="{ color: theme === 'light' ? '#333333' : '#EBEAEA' }">各部门通勤率</div>
                <el-select v-model="selectValue" placeholder="Select" size="small" style="width: 100px">
                    <el-option v-for="i in departmentList" :key="i.departId" :label="i.department_Name"
                        :value="i.departId" />
                </el-select>
            </div>
        </template>
        <template v-slot:body>
            <div class="echart" ref="chart"></div>
        </template>
    </Card>
</template>


<script setup>
import { onMounted, ref, reactive, nextTick, getCurrentInstance, onBeforeUnmount, watch, markRaw } from "vue"
// 引入pinia响应式
import { storeToRefs } from 'pinia'
// 引入layout仓库
import { useLayoutStore } from '../../../stores/layout'
// 引入login仓库
import { useLoginStore } from '../../../stores/login'
// 引入employees仓库
import { useEmployeesStore } from '../../../stores/employees'
//API
import employees from '../../../api'

// 绘制echart的元素
let chart = ref(null)

// echart
let myChart = ref(null)

let internalInstance = getCurrentInstance();

//获取全局echarts
let $echarts = internalInstance.appContext.config.globalProperties.$echarts;

let selectValue = ref(null)


// 获取layout仓库
let layoutStore = useLayoutStore()

// 获取login仓库
let loginStore = useLoginStore()

// 获取employees仓库
let employeesStore = useEmployeesStore()

// employees仓库的action方法
const {
    //获取部门信息
    getDepartmentList,
} = employeesStore

// employees仓库的state数据
const {
    // 部门列表
    departmentList,
} = storeToRefs(employeesStore)

// login仓库的state数据
const {
    //部门ID
    departId,
} = storeToRefs(loginStore)

let option = ref({
    tooltip: {
        trigger: 'item'
    },
    legend: {
        orient: 'vertical',
        left: 'right',
        textStyle: {
            color: ""
        },
    },
    series: [
        {
            type: 'pie',
            radius: '80%',
            data: [],
            label: {
                color: ""
            }
        }
    ]
})

// layout仓库的state数据
const {
    // 主题
    theme,
    // 菜单伸缩
    collapse
} = storeToRefs(layoutStore)

//监听生产在库折线图数据
watch(selectValue, async () => {
    await employees.reqAvgDepart(selectValue.value).then((res) => {
        let data = res.data
        option.value.series[0].data = data
        initChart()

    })
})

//监听生产在库折线图数据
watch(option, () => {
    nextTick(() => {
        myChart.value.setOption(option.value);
    })
})

//监听生产在库折线图数据
watch(collapse, () => {
    setTimeout(() => {
        myChart.value.resize()
        initChart()
    }, 500);
})

//监听生产在库折线图数据
watch(theme, () => {
    if (theme.value === "light") {
        option.value.legend.textStyle.color = "#000"
        option.value.series[0].label.color = "#000"

    } else {
        option.value.legend.textStyle.color = "#fff"
        option.value.series[0].label.color = "#fff"
    }
    nextTick(() => {
        myChart.value.setOption(option.value);
    })
})

//创建echart图
function initChart() {
    if (theme.value === "light") {
        option.value.legend.textStyle.color = "#000"
        option.value.series[0].label.color = "#000"
    } else {
        option.value.legend.textStyle.color = "#fff"
        option.value.series[0].label.color = "#fff"
    }
    myChart.value = markRaw($echarts.init(chart.value));
    myChart.value.setOption(option.value);
}

//生产在库折线图自适应
function resizeEcahrt() {
    myChart.value.resize()
    initChart()
}

onMounted(async () => {
    selectValue.value = departId.value
    await getDepartmentList()
    await employees.reqAvgDepart(selectValue.value).then((res) => {
        let data = res.data
        option.value.series[0].data = data
        initChart()

    })
    window.addEventListener('resize', resizeEcahrt, true);
})

onBeforeUnmount(() => {
    window.removeEventListener('resize', resizeEcahrt, true);
})






</script>

<style lang="less" scoped>
.echart_wrap {
    width: 100%;
}

.echart {
    width: 100%;
    height: 250px;
}

.title{
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 17px;
}
</style>