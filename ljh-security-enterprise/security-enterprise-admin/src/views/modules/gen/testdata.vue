<template>
  <el-card shadow="never" class="aui-card--fill">
    <div class="mod-gen__testdata">
      <el-form :inline="true" :model="dataForm" @keyup.enter.native="getDataList()">
        <el-form-item>
          <el-input v-model="dataForm.username" placeholder="用户名" clearable></el-input>
        </el-form-item>
        <el-form-item>
          <ren-select v-model="dataForm.gender" dict-type="gender" placeholder="性别"></ren-select>
        </el-form-item>
        <el-form-item>
          <el-date-picker
            v-model="daterange"
            type="daterange"
            value-format="yyyy-MM-dd"
            :range-separator="$t('datePicker.range')"
            :start-placeholder="$t('datePicker.start')"
            :end-placeholder="$t('datePicker.end')">
          </el-date-picker>
        </el-form-item>
        <el-form-item>
          <el-button @click="getDataList()">{{ $t('query') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button type="info" @click="exportHandle()">{{ $t('export') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('gen:testdata:save')" type="primary" @click="addOrUpdateHandle()">{{ $t('add') }}</el-button>
        </el-form-item>
        <el-form-item>
          <el-button v-if="$hasPermission('gen:testdata:delete')" type="danger" @click="deleteHandle()">{{ $t('deleteBatch') }}</el-button>
        </el-form-item>
      </el-form>
      <el-table v-loading="dataListLoading" :data="dataList" border @selection-change="dataListSelectionChangeHandle" style="width: 100%;">
        <el-table-column type="selection" header-align="center" align="center" width="50"></el-table-column>
        <el-table-column prop="username" label="用户名" header-align="center" align="center"></el-table-column>
        <el-table-column prop="realName" label="姓名" header-align="center" align="center"></el-table-column>
        <el-table-column prop="gender" label="性别" header-align="center" align="center">
          <template slot-scope="scope">
            {{ $getDictLabel("gender", scope.row.gender) }}
          </template>
        </el-table-column>
        <el-table-column prop="email" label="邮箱" header-align="center" align="center"></el-table-column>
        <el-table-column prop="noticeType" label="类型" header-align="center" align="center">
          <template slot-scope="scope">
            {{ $getDictLabel("notice_type", scope.row.noticeType) }}
          </template>
        </el-table-column>
        <el-table-column prop="createDate" label="创建时间" header-align="center" align="center"></el-table-column>
        <el-table-column :label="$t('handle')" fixed="right" header-align="center" align="center" width="150">
          <template slot-scope="scope">
            <el-button v-if="$hasPermission('gen:testdata:update')" type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">{{ $t('update') }}</el-button>
            <el-button v-if="$hasPermission('gen:testdata:delete')" type="text" size="small" @click="deleteHandle(scope.row.id)">{{ $t('delete') }}</el-button>
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
import AddOrUpdate from './testdata-add-or-update'
export default {
  mixins: [mixinViewModule],
  data () {
    return {
      mixinViewModuleOptions: {
        getDataListURL: '/gen/testdata/page',
        getDataListIsPage: true,
        exportURL: '/gen/testdata/export',
        deleteURL: '/gen/testdata',
        deleteIsBatch: true
      },
      daterange: null,
      dataForm: {
        username: '',
        gender: '',
        startDate: '',
        endDate: '',
      }
    }
  },
  watch: {
    daterange (val) {
      if (val == null) {
        this.dataForm.startDate = null
        this.dataForm.endDate = null
      } else {
        this.dataForm.startDate = val[0]
        this.dataForm.endDate = val[1]
      }
    },
  },
  components: {
    AddOrUpdate
  }
}
</script>
