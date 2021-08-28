<!--  流程业务表单   -->
<template>
    <el-card shadow="never" class="aui-card--fill">
        <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmitHandle()" :label-width="$i18n.locale === 'en-US' ? '120px' : '80px'">
            <el-form-item label="销售订单号" prop="salesOrderNum">
                <el-input v-model="dataForm.salesOrderNum" placeholder="销售订单号"></el-input>
            </el-form-item>
        </el-form>
        <!--  流程综合组件   -->
        <ren-process-multiple v-if="processVisible" updateInstanceIdUrl="/sales/salesorder/updateInstanceId" saveFormUrl="/sales/salesorder" dataFormName="dataForm" ref="renProcessMultiple" ></ren-process-multiple>
    </el-card>
</template>

<script>
    // 引入工作流公共方法
    import processModule from '@/mixins/process-module'
    export default {
        // 注入公共方法
        mixins: [processModule],
        data () {
            return {
                visible: false,
                // 表单属性是否可编辑
                fieldDisabled: false,
                dataForm: {
                    id: '',
                    applyPost: '',
                    entryDate: '',
                    correctionDate: '',
                    workContent: '',
                    achievement: '',
                    creator: '',
                    createDate: ''
                }
            }
        },
        created () {
            // 将业务KEY赋值给表单
            this.dataForm.id = this.$route.params.businessKey
            this.init()
            // 流程回调
            var callbacks = {
                startProcessSuccessCallback: this.closeCurrentTab,
                startProcessErrorCallback: this.startProcessErrorCallback,
                taskHandleSuccessCallback: this.closeCurrentTab,
                taskHandleErrorCallback: this.taskHandleErrorCallback,
                formSaveSuccessCallback: null,
                formSaveErrorCallback: null
            }
            // 初始化综合组件
            this.initProcessMultiple(callbacks)
        },
        computed: {
            dataRule () {
                return {
                }
            }
        },
        methods: {
            init () {
                this.visible = true
                this.$nextTick(() => {
                    this.$refs['dataForm'].resetFields()
                    if (this.dataForm.id) {
                        // 如业务KEY已存在，不允许编辑
                        this.fieldDisabled = true
                        this.getInfo()
                    }
                })
            },
            // 获取信息
            getInfo () {
                this.$http.get(`/sales/salesorder/${this.dataForm.id}`).then(({ data: res }) => {
                    if (res.code !== 0) {
                        return this.$message.error(res.msg)
                    }
                    this.dataForm = {
                        ...this.dataForm,
                        ...res.data
                    }
                }).catch(() => {})
            },
            // 启动流程出错回调
            startProcessErrorCallback (data) {
                console.log(data)
            },
            // 任务处理出错回调
            taskHandleErrorCallback (data) {
            }
        }
    }
</script>
