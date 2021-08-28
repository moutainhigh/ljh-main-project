<template>
  <el-dialog :visible.sync="visible" :title="!dataForm.id ? $t('add') : $t('update')" :close-on-click-modal="false" :close-on-press-escape="false">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmitHandle()" :label-width="$i18n.locale === 'en-US' ? '120px' : '80px'">
      <el-form-item label="" prop="id">
        <el-input v-model="dataForm.id" placeholder=""></el-input>
      </el-form-item>
      <el-form-item label="销售订单号" prop="salesOrderNum">
        <el-input v-model="dataForm.salesOrderNum" placeholder="销售订单号"></el-input>
      </el-form-item>
      <el-form-item label="客户订单号" prop="customerPurchaseNum">
        <el-input v-model="dataForm.customerPurchaseNum" placeholder="客户订单号"></el-input>
      </el-form-item>
      <el-form-item label="客户" prop="customerId">
        <ren-select v-model="dataForm.customerId" dict-type="YesOrNo" placeholder="客户"></ren-select>
      </el-form-item>
      <el-form-item label="币种" prop="currencyId">
        <ren-select v-model="dataForm.currencyId" dict-type="YesOrNo" placeholder="币种"></ren-select>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input type="textarea" v-model="dataForm.remark"></el-input>
      </el-form-item>
      <el-form-item label="附件" prop="attachment">
        <el-input v-model="dataForm.attachment" placeholder="附件"></el-input>
      </el-form-item>
      <el-form-item label="状态" prop="state">
        <el-input v-model="dataForm.state" placeholder="状态"></el-input>
      </el-form-item>
    </el-form>
    <template slot="footer">
      <el-button @click="visible = false">{{ $t('cancel') }}</el-button>
      <!--  流程启动组件  -->
      <ren-process-start v-if="processVisible" updateInstanceIdUrl="/sales/salesorder/updateInstanceId" saveFormUrl="/sales/salesorder" dataFormName="dataForm" ref="renProcessStart" ></ren-process-start>
    </template>
  </el-dialog>
</template>

<script>
  // 引入工作流公共方法
  import processModule from '@/mixins/process-module'
  export default {
    // 注入公共方法
    mixins: [processModule],
    data () {
      return {
        // 是否显示流程启动组件
        processVisible: true,
        visible: false,
        dataForm: {
          id: '',
          salesOrderNum: '',
          customerPurchaseNum: '',
          customerId: '',
          currencyId: '',
          remark: '',
          attachment: '',
          state: '',
          creator: '',
          createDate: '',
          updater: '',
          updateDate: '',
        }
      }
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
            this.getInfo()
          }
          // 将业务组件对象赋值给流程（回调时需要用到）
          this.$refs.renProcessStart.rootObj = this
          // 配置回调函数
          this.$refs.renProcessStart.callbacks = {
            startProcessSuccessCallback: this.closeCurrentDialog,
            startProcessErrorCallback: this.startProcessErrorCallback,
            formSaveSuccessCallback: null,
            formSaveErrorCallback: null
          }
          // 配置流程定义KEY
          this.$refs.renProcessStart.dataForm.processDefinitionKey = 'salesorderprocess'
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
      closeCurrentDialog () {
        this.visible = false
        this.$emit('refreshDataList')
      }
    }
  }
</script>
