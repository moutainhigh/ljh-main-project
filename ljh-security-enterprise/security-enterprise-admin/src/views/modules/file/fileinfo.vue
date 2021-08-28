<template>
  <el-card shadow="never" class="aui-card--fill">
    <div class="mod-file__fileinfo">
      <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item>
          <el-input v-model="dataForm.filename" placeholder="文件名称" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.effective" placeholder="是否有效" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.format" placeholder="文件格式" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.filenum" placeholder="文件编号" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.stdstate" placeholder="标准状态" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()">{{ $t('query') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="info" @click="exportHandle()">{{ $t('export') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('file:fileinfo:save')" type="primary" @click="addOrUpdateHandle()">{{ $t('add') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('file:fileinfo:delete')" type="danger" @click="deleteHandle()">{{ $t('deleteBatch') }}</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="dataListLoading" :data="dataList" border @selection-change="dataListSelectionChangeHandle" style="width: 100%;">
        <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
        <el-table-column prop="fileid" label="文件id" header-align="center" align="center"></el-table-column>
        <el-table-column prop="filename" label="文件名称" header-align="center" align="center"></el-table-column>
        <el-table-column prop="remark" label="备注" header-align="center" align="center"></el-table-column>
        <el-table-column prop="revision" label="版本" header-align="center" align="center"></el-table-column>
        <el-table-column prop="effective" label="是否有效" header-align="center" align="center"></el-table-column>
        <el-table-column prop="format" label="文件格式" header-align="center" align="center"></el-table-column>
        <el-table-column prop="size" label="文件大小" header-align="center" align="center"></el-table-column>
        <el-table-column prop="filenum" label="文件编号" header-align="center" align="center"></el-table-column>
        <el-table-column prop="mgtremark" label="管理备注" header-align="center" align="center"></el-table-column>
        <el-table-column prop="stdstate" label="标准状态" header-align="center" align="center"></el-table-column>
        <el-table-column prop="updater" label="修改人" header-align="center" align="center"></el-table-column>
        <el-table-column prop="updatedate" label="修改时间" header-align="center" align="center"></el-table-column>
        <el-table-column prop="creator" label="创建人" header-align="center" align="center"></el-table-column>
        <el-table-column prop="createDate" label="创建时间" header-align="center" align="center"></el-table-column>
        <el-table-column :label="$t('handle')" fixed="right" header-align="center" align="center" width="150">
          <template slot-scope="scope">
            <el-button v-if="$hasPermission('file:fileinfo:update')" type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">{{ $t('update') }}</el-button>
            <el-button v-if="$hasPermission('file:fileinfo:delete')" type="text" size="small" @click="deleteHandle(scope.row.id)">{{ $t('delete') }}</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        :current-page="page"
        :page-sizes="[10, 20, 50, 100]"
        :page-size="limit"
        :total="total"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="pageSizeChangeHandle"
        @current-change="pageCurrentChangeHandle">
      </el-pagination>
      <!-- 弹窗, 新增 / 修改 -->
      <add-or-update v-if="addOrUpdateVisible" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
    </div>
  </el-card>
</template>

<script>
import mixinViewModule from '@/mixins/view-module'
import AddOrUpdate from './fileinfo-add-or-update'
export default {
  mixins: [mixinViewModule],
  data () {
    return {
      mixinViewModuleOptions: {
        getDataListURL: '/file/fileinfo/page',
        getDataListIsPage: true,
        exportURL: '/file/fileinfo/export',
        deleteURL: '/file/fileinfo',
        deleteIsBatch: true
      },
      dataForm: {
        filename: '',
        effective: '',
        format: '',
        filenum: '',
        stdstate: '',
      }
    }
  },
  watch: {
  },
  components: {
    AddOrUpdate
  }
}
</script>
