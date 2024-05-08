<template>
    <Card title="每个月员工迟到次数" class="echart_wrap" :theme="theme">
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
//API
import employees from '../../../api'

// 绘制echart的元素
let chart = ref(null)

// echart
let myChart = ref(null)

let internalInstance = getCurrentInstance();

//获取全局echarts
let $echarts = internalInstance.appContext.config.globalProperties.$echarts;


// 获取layout仓库
let layoutStore = useLayoutStore()

let option = ref({
    grid: {
        top: "15%",
        bottom: "13%",
        left: "30",
        right: "20",
    },
    tooltip: {
        show: true,
        trigger: 'axis'
    },
    legend: {
        data: ['迟到趋势'],
        textStyle: {
            color: ""
        },
        right: 0,

    },
    xAxis: {
        type: 'category',
        axisLine: {
            lineStyle: {
                color: ""
            }
        },
        data: [],
        axisLabel: {
            color: ""
        }
    },
    yAxis: {
        type: 'value',
        axisLabel: {
            color: ""
        },
    },
    series: [
        {
            name: "迟到趋势",
            data: [],
            type: 'line',
            smooth: true,
            symbol: 'none',
            lineStyle: {
                color: "#000"
            },
            itemStyle: {
                color: "#000"
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
        option.value.xAxis.axisLine.lineStyle.color = "#000"
        option.value.xAxis.axisLabel.color = "#000"

        option.value.yAxis.axisLabel.color = "#000"
        option.value.legend.textStyle.color = "#000"

        option.value.series[0].lineStyle.color = "#f3a694"
        option.value.series[0].itemStyle.color = "#f3a694"
    } else {
        option.value.xAxis.axisLine.lineStyle.color = "#fff"
        option.value.xAxis.axisLabel.color = "#fff"

        option.value.yAxis.axisLabel.color = "#fff"

        option.value.legend.textStyle.color = "#fff"

        option.value.series[0].lineStyle.color = "#30d5c8"
        option.value.series[0].itemStyle.color = "#30d5c8"
    }
    nextTick(() => {
        myChart.value.setOption(option.value);
    })
})

//创建echart图
function initChart() {
    if (theme.value === "light") {
        option.value.xAxis.axisLine.lineStyle.color = "#000"
        option.value.xAxis.axisLabel.color = "#000"

        option.value.yAxis.axisLabel.color = "#000"
        option.value.legend.textStyle.color = "#000"

        option.value.series[0].lineStyle.color = "#f3a694"
        option.value.series[0].itemStyle.color = "#f3a694"
    } else {
        option.value.xAxis.axisLine.lineStyle.color = "#fff"
        option.value.xAxis.axisLabel.color = "#fff"

        option.value.yAxis.axisLabel.color = "#fff"
        option.value.legend.textStyle.color = "#fff"

        option.value.series[0].lineStyle.color = "#30d5c8"
        option.value.series[0].itemStyle.color = "#30d5c8"
    }
    myChart.value = markRaw($echarts.init(chart.value));
    myChart.value.setOption(option.value);
}

//生产在库折线图自适应
const resizeEcahrt = () => {
    myChart.value.resize()
    initChart()
}

onMounted(async () => {
    await employees.reqmonthChidao().then((res) => {
        let xAxisData = []
        let data = []
        res.data.forEach(item => {
            xAxisData.push(item.month)
            data.push(item.count)
        })
        option.value.series[0].data = data
        option.value.xAxis.data = xAxisData
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
</style>