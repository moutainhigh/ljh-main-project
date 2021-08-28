<template>
  <el-card shadow="never" class="aui-card--fill">
    <div class="mod-basics__productcode">
      <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item>
          <el-input v-model="dataForm.code" placeholder="编码" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.productName" placeholder="产品名称" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.drawingNum" placeholder="产品图号" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.drawingRev" placeholder="图号版本" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.materialName" placeholder="材质名称" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.materialCodeNum" placeholder="物料号" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()">{{ $t('query') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="info" @click="exportHandle()">{{ $t('export') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('basics:productcode:save')" type="primary" @click="addOrUpdateHandle()">{{ $t('add') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('basics:productcode:delete')" type="danger" @click="deleteHandle()">{{ $t('deleteBatch') }}</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="dataListLoading" :data="dataList" border @selection-change="dataListSelectionChangeHandle" style="width: 100%;">
        <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
        <el-table-column prop="code" label="编码" header-align="center" align="center"></el-table-column>
        <el-table-column prop="productName" label="产品名称" header-align="center" align="center"></el-table-column>
        <el-table-column prop="drawingNum" label="产品图号" header-align="center" align="center"></el-table-column>
        <el-table-column prop="drawingRev" label="图号版本" header-align="center" align="center"></el-table-column>
        <el-table-column prop="materialName" label="材质名称" header-align="center" align="center"></el-table-column>
        <el-table-column prop="materialCodeNum" label="物料号" header-align="center" align="center"></el-table-column>
        <el-table-column prop="remark" label="备注" header-align="center" align="center"></el-table-column>
        <el-table-column prop="attachment" label="附件" header-align="center" align="center"></el-table-column>
        <el-table-column prop="creator" label="创建人" header-align="center" align="center"></el-table-column>
        <el-table-column prop="createDate" label="创建时间" header-align="center" align="center"></el-table-column>
        <el-table-column prop="state" label="状态" header-align="center" align="center"></el-table-column>
        <el-table-column :label="$t('handle')" fixed="right" header-align="center" align="center" width="150">
          <template slot-scope="scope">
            <el-button v-if="$hasPermission('basics:productcode:update')" type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">{{ $t('update') }}</el-button>
            <el-button v-if="$hasPermission('basics:productcode:delete')" type="text" size="small" @click="deleteHandle(scope.row.id)">{{ $t('delete') }}</el-button>
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
import AddOrUpdate from './productcode-add-or-update'
export default {
  mixins: [mixinViewModule],
  data () {
    return {
      mixinViewModuleOptions: {
        getDataListURL: '/basics/productcode/page',
        getDataListIsPage: true,
        exportURL: '/basics/productcode/export',
        deleteURL: '/basics/productcode',
        deleteIsBatch: true
      },
      dataForm: {
        code: '',
        productName: '',
        drawingNum: '',
        drawingRev: '',
        materialName: '',
        materialCodeNum: '',
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
