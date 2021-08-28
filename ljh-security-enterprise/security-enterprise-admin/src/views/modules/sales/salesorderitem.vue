<template>
  <el-card shadow="never" class="aui-card--fill">
    <div class="mod-sales__salesorderitem">
      <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item>
          <el-input v-model="dataForm.salesOrderId" placeholder="销售订单id" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.productCode" placeholder="产品编码" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()">{{ $t('query') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="info" @click="exportHandle()">{{ $t('export') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('sales:salesorderitem:save')" type="primary" @click="addOrUpdateHandle()">{{ $t('add') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('sales:salesorderitem:delete')" type="danger" @click="deleteHandle()">{{ $t('deleteBatch') }}</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="dataListLoading" :data="dataList" border @selection-change="dataListSelectionChangeHandle" style="width: 100%;">
        <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
        <el-table-column prop="salesOrderId" label="销售订单id" header-align="center" align="center"></el-table-column>
        <el-table-column prop="lineNum" label="行号" header-align="center" align="center"></el-table-column>
        <el-table-column prop="productCode" label="产品编码" header-align="center" align="center"></el-table-column>
        <el-table-column prop="qty" label="数量" header-align="center" align="center"></el-table-column>
        <el-table-column prop="needDate" label="需求日期" header-align="center" align="center"></el-table-column>
        <el-table-column prop="planFinishDate" label="计划完成日期" header-align="center" align="center"></el-table-column>
        <el-table-column prop="remark" label="备注" header-align="center" align="center"></el-table-column>
        <el-table-column prop="creator" label="创建人" header-align="center" align="center"></el-table-column>
        <el-table-column prop="createDate" label="创建时间" header-align="center" align="center"></el-table-column>
        <el-table-column :label="$t('handle')" fixed="right" header-align="center" align="center" width="150">
          <template slot-scope="scope">
            <el-button v-if="$hasPermission('sales:salesorderitem:update')" type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">{{ $t('update') }}</el-button>
            <el-button v-if="$hasPermission('sales:salesorderitem:delete')" type="text" size="small" @click="deleteHandle(scope.row.id)">{{ $t('delete') }}</el-button>
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
import AddOrUpdate from './salesorderitem-add-or-update'
export default {
  mixins: [mixinViewModule],
  data () {
    return {
      mixinViewModuleOptions: {
        getDataListURL: '/sales/salesorderitem/page',
        getDataListIsPage: true,
        exportURL: '/sales/salesorderitem/export',
        deleteURL: '/sales/salesorderitem',
        deleteIsBatch: true
      },
      dataForm: {
        salesOrderId: '',
        productCode: '',
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
