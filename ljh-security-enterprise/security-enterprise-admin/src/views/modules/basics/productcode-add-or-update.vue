<template>
  <el-dialog :visible.sync="visible" :title="!dataForm.id ? $t('add') : $t('update')" :close-on-click-modal="false" :close-on-press-escape="false">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmitHandle()" :label-width="$i18n.locale === 'en-US' ? '120px' : '80px'">
      <el-form-item label="编码" prop="code">
        <el-input v-model="dataForm.code" placeholder="编码"></el-input>
      </el-form-item>
      <el-form-item label="产品名称" prop="productName">
        <el-input v-model="dataForm.productName" placeholder="产品名称"></el-input>
      </el-form-item>
      <el-form-item label="产品图号" prop="drawingNum">
        <el-input v-model="dataForm.drawingNum" placeholder="产品图号"></el-input>
      </el-form-item>
      <el-form-item label="图号版本" prop="drawingRev">
        <el-input v-model="dataForm.drawingRev" placeholder="图号版本"></el-input>
      </el-form-item>
      <el-form-item label="材质名称" prop="materialName">
        <el-input v-model="dataForm.materialName" placeholder="材质名称"></el-input>
      </el-form-item>
      <el-form-item label="物料号" prop="materialCodeNum">
        <el-input v-model="dataForm.materialCodeNum" placeholder="物料号"></el-input>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input type="textarea" v-model="dataForm.remark"></el-input>
      </el-form-item>
      <el-form-item label="附件" prop="attachment">
        <el-input v-model="dataForm.attachment" placeholder="附件"></el-input>
      </el-form-item>
      <el-form-item label="创建人" prop="creator">
        <el-input v-model="dataForm.creator" placeholder="创建人"></el-input>
      </el-form-item>
      <el-form-item label="创建时间" prop="createDate">
        <el-input v-model="dataForm.createDate" placeholder="创建时间"></el-input>
      </el-form-item>
      <el-form-item label="状态" prop="state">
        <el-input v-model="dataForm.state" placeholder="状态"></el-input>
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
        code: '',
        productName: '',
        drawingNum: '',
        drawingRev: '',
        materialName: '',
        materialCodeNum: '',
        remark: '',
        attachment: '',
        creator: '',
        createDate: '',
        state: '',
      }
    }
  },
  computed: {
    dataRule () {
      return {
        code: [
          { required: true, message: this.$t('validate.required'), trigger: 'blur' }
        ],
        productName: [
          { required: true, message: this.$t('validate.required'), trigger: 'blur' }
        ],
        drawingNum: [
          { required: true, message: this.$t('validate.required'), trigger: 'blur' }
        ],
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
      this.$http.get('/basics/productcode/' + this.dataForm.id).then(({ data: res }) => {
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
        this.$http[!this.dataForm.id ? 'post' : 'put']('/basics/productcode/', this.dataForm).then(({ data: res }) => {
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
