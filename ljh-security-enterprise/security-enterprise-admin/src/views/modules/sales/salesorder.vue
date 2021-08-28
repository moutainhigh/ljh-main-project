<template>
  <el-card shadow="never" class="aui-card--fill">
    <div class="mod-sales__salesorder">
      <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item>
          <el-input v-model="dataForm.salesOrderNum" placeholder="销售订单号" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <el-input v-model="dataForm.customerPurchaseNum" placeholder="客户订单号" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <ren-select v-model="dataForm.customerId" dict-type="YesOrNo" placeholder="客户"></ren-select>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()">{{ $t('query') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="info" @click="exportHandle()">{{ $t('export') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('sales:salesorder:save')" type="primary" @click="addOrUpdateHandle()">{{ $t('add') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('sales:salesorder:delete')" type="danger" @click="deleteHandle()">{{ $t('deleteBatch') }}</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="dataListLoading" :data="dataList" border @selection-change="dataListSelectionChangeHandle" style="width: 100%;">
        <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
        <el-table-column prop="instanceId" :label="$t('running.id')" header-align="center" align="center"></el-table-column>
        <el-table-column prop="salesOrderNum" label="销售订单号" header-align="center" align="center"></el-table-column>
        <el-table-column prop="customerPurchaseNum" label="客户订单号" header-align="center" align="center"></el-table-column>
        <el-table-column prop="customerId" label="客户" header-align="center" align="center">
          <template slot-scope="scope">
            {{ $getDictLabel("YesOrNo", scope.row.customerId) }}
          </template>
        </el-table-column>
        <el-table-column prop="currencyId" label="币种" header-align="center" align="center">
          <template slot-scope="scope">
            {{ $getDictLabel("YesOrNo", scope.row.currencyId) }}
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" header-align="center" align="center"></el-table-column>
        <el-table-column prop="state" label="状态" header-align="center" align="center"></el-table-column>
        <el-table-column prop="creator" label="创建人" header-align="center" align="center"></el-table-column>
        <el-table-column prop="createDate" label="创建时间" header-align="center" align="center"></el-table-column>
        <el-table-column prop="updater" label="修改人" header-align="center" align="center"></el-table-column>
        <el-table-column prop="updateDate" label="修改时间" header-align="center" align="center"></el-table-column>
        <el-table-column :label="$t('handle')" fixed="right" header-align="center" align="center" width="150">
          <template slot-scope="scope">
            <el-button type="text" size="small" @click="showDetail(scope.row)">{{ $t('process.viewFlowImage') }}</el-button>
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
  import AddOrUpdate from './salesorder-add-or-update'
  // 引入工作流公共方法
  import processModule from '@/mixins/process-module'
  export default {
    // 注入公共方法
    mixins: [mixinViewModule, processModule],
    data () {
      return {
        mixinViewModuleOptions: {
          getDataListURL: '/sales/salesorder/page',
          getDataListIsPage: true,
          exportURL: '/sales/salesorder/export',
          deleteURL: '/sales/salesorder',
          deleteIsBatch: true
        },
        dataForm: {
          id: '',
          salesOrderNum: '',
          customerPurchaseNum: '',
          customerId: '',
        },
        // 流程定义KEY
        procDefKey: 'salesorderprocess'
      }
    },
    components: {
      AddOrUpdate
    },
    methods: {
      // 查看流程处理详情
      showDetail (row) {
        if (!row.id) {
          return this.$message.error(this.$t('task.detailError'))
        }
        var params = {
          businessKey: row.id,
          procDefKey: this.procDefKey
        }
        this.getProcDefBizRouteAndProcessInstance(params, this.forwardDetail)
      }
    }
  }
</script>
