<template>
  <el-dialog :visible.sync="visible" :title="!dataForm.id ? $t('add') : $t('update')" :close-on-click-modal="false" :close-on-press-escape="false">
    <el-form :model="dataForm" :rules="dataRule" ref="dataForm" @keyup.enter.native="dataFormSubmitHandle()" :label-width="$i18n.locale === 'en-US' ? '120px' : '80px'">
      <el-upload
              name="file"
              class="upload-demo"
              :action="this.uploadAction"
              :on-success="uploadSuccess"
              :on-error="uploadError"
              :show-file-list="false">
        <el-button size="small" type="primary">点击上传</el-button>
      </el-upload>
      <el-form-item label="文件id" prop="fileid">
        <el-input v-model="dataForm.fileid" placeholder="文件id"></el-input>
      </el-form-item>
      <el-form-item label="文件id" prop="menuid">
        <el-input v-model="dataForm.menuid" placeholder="文件id"></el-input>
      </el-form-item>
      <el-form-item label="文件名称" prop="filename">
        <el-input v-model="dataForm.filename" placeholder="文件名称"></el-input>
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="dataForm.remark" placeholder="备注"></el-input>
      </el-form-item>
      <el-form-item label="版本" prop="revision">
        <el-input v-model="dataForm.revision" placeholder="版本"></el-input>
      </el-form-item>
      <el-form-item label="是否有效" prop="effective">
        <el-input v-model="dataForm.effective" placeholder="是否有效"></el-input>
      </el-form-item>
      <el-form-item label="文件格式" prop="format">
        <el-input v-model="dataForm.format" placeholder="文件格式"></el-input>
      </el-form-item>
      <el-form-item label="文件大小" prop="size">
        <el-input v-model="dataForm.size" placeholder="文件大小"></el-input>
      </el-form-item>
      <el-form-item label="文件编号" prop="filenum">
        <el-input v-model="dataForm.filenum" placeholder="文件编号"></el-input>
      </el-form-item>
      <el-form-item label="管理备注" prop="mgtremark">
        <el-input v-model="dataForm.mgtremark" placeholder="管理备注"></el-input>
      </el-form-item>
      <el-form-item label="标准状态" prop="stdstate">
        <el-input v-model="dataForm.stdstate" placeholder="标准状态"></el-input>
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
import Cookies from "js-cookie";
export default {
  props:['menu-id','menu-name'],
  data () {
    return {
      uploadAction:`${window.SITE_CONFIG['apiURL']}/file/fileinfo/uploadfile?menuName=`+encodeURIComponent(this.menuName+this.menuId)+`&&token=${Cookies.get('token')}`,
      visible: false,
      dataForm: {
        id: '',
        fileid: '',
        filename: '',
        menuid: '',
        remark: '',
        revision: '',
        effective: '',
        format: '',
        size: '',
        filenum: '',
        mgtremark: '',
        stdstate: '',
        updater: '',
        updatedate: '',
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
    uploadSuccess(response, file, fileList){
      this.dataForm=response.data;
      this.dataForm.menuid = this.menuId;
    },
    uploadError(err, file, fileList){
      this.$message.info(err);
    },
    // 获取信息
    getInfo () {
      this.$http.get('/file/fileinfo/' + this.dataForm.id).then(({ data: res }) => {
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
        this.$http[!this.dataForm.id ? 'post' : 'put']('/file/fileinfo/', this.dataForm).then(({ data: res }) => {
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
