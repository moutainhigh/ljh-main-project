<template>
  <el-dialog :visible.sync="visible" :title="!dataForm.id ? $t('add') : $t('update')" :close-on-click-modal="false" :close-on-press-escape="false">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmitHandle()" :label-width="$i18n.locale === 'en-US' ? '120px' : '80px'">
      <el-form-item label="销售订单id" prop="salesOrderId">
        <el-input v-model="dataForm.salesOrderId" placeholder="销售订单id"></el-input>
      </el-form-item>
      <el-form-item label="行号" prop="lineNum">
        <el-input v-model="dataForm.lineNum" placeholder="行号"></el-input>
      </el-form-item>
      <el-form-item label="产品编码" prop="productCode">
        <el-input v-model="dataForm.productCode" placeholder="产品编码"></el-input>
      </el-form-item>
      <el-form-item label="数量" prop="qty">
        <el-input v-model="dataForm.qty" placeholder="数量"></el-input>
      </el-form-item>
      <el-form-item label="需求日期" prop="needDate">
        <el-date-picker type="date" placeholder="需求日期" v-model="dataForm.needDate"></el-date-picker>
      </el-form-item>
      <el-form-item label="计划完成日期" prop="planFinishDate">
        <el-date-picker type="date" placeholder="计划完成日期" v-model="dataForm.planFinishDate"></el-date-picker>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input type="textarea" v-model="dataForm.remark"></el-input>
      </el-form-item>
    </el-form>
    <template slot="footer">
      <el-button @click="visible = false">{{ $t('cancel') }}</el-button>
      <el-button type="primary" @click="dataFormSubmitHandle()">{{ $t('confirm') }}</el-button>
    </template>
  </el-dialog>
</template>

<script>
import debounce from 'lodash/debounce'
export default {
  data () {
    return {
      visible: false,
      dataForm: {
        id: '',
        salesOrderId: '',
        lineNum: '',
        productCode: '',
        qty: '',
        needDate: '',
        planFinishDate: '',
        remark: '',
        creator: '',
        createDate: '',
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
      })
    },
    // 获取信息
    getInfo () {
      this.$http.get('/sales/salesorderitem/' + this.dataForm.id).then(({ data: res }) => {
        if (res.code !== 0) {
          return this.$message.error(res.msg)
        }
        this.dataForm = {
          ...this.dataForm,
          ...res.data
        }
      }).catch(() => {})
    },
    // 表单提交
    dataFormSubmitHandle: debounce(function () {
      this.$refs['dataForm'].validate((valid) => {
        if (!valid) {
          return false
        }
        this.$http[!this.dataForm.id ? 'post' : 'put']('/sales/salesorderitem/', this.dataForm).then(({ data: res }) => {
          if (res.code !== 0) {
            return this.$message.error(res.msg)
          }
          this.$message({
            message: this.$t('prompt.success'),
            type: 'success',
            duration: 500,
            onClose: () => {
              this.visible = false
              this.$emit('refreshDataList')
            }
          })
        }).catch(() => {})
      })
    }, 1000, { 'leading': true, 'trailing': false })
  }
}
</script>
