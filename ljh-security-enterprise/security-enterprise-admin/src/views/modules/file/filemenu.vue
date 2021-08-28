<template>
  <el-container style=" border: 1px solid #eee">
    <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
      <el-card shadow="never" class="aui-card--fill">
        <div class="custom-tree-container">
          <div class="block">
            <el-tree
                    :data="this.dataList1"
                    :props="this.defaultProps"
                    node-key="id"
                    @node-click="getFill">
            </el-tree>
          </div>
        </div>
      </el-card>
    </el-aside>

      <el-card shadow="never" class="aui-card--fill">
        <el-button v-if="this.isShowDownload" @click="download" type="primary">下载</el-button>
        <el-button v-if="this.isShowPreview" @click="preview" type="primary">预览</el-button>
        <el-button v-if="this.isShowAdd" type="primary" @click="addOrUpdateHandle()">{{ $t('add') }}</el-button>
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
          </el-form>
          <el-table v-loading="dataListLoading" ref="tbl" :height="tableHeight" :data="dataList" border @selection-change="dataListSelectionChangeHandle" style="width: 100%;">
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
            <el-table-column prop="createdate" label="创建时间" header-align="center" align="center"></el-table-column>
            <el-table-column :label="$t('handle')" fixed="right" header-align="center" align="center" width="150">
              <template slot-scope="scope">
                <el-button type="text" size="small" @click="addOrUpdateHandle(scope.row.id)">{{ $t('update') }}</el-button>
                <el-button type="text" size="small" @click="deleteHandle(scope.row.id)">{{ $t('delete') }}</el-button>
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
          <add-or-update v-if="addOrUpdateVisible" :menu-name="this.menuName" :menu-id="this.dataForm.menuid" ref="addOrUpdate" @refreshDataList="getDataList"></add-or-update>
        </div>
      </el-card>
  </el-container>
</template>

<script>
import mixinViewModule from '@/mixins/view-module'
import AddOrUpdate from './fileinfo-add-or-update'
import qs from 'qs'
import Cookies from 'js-cookie'
export default {
  mixins: [mixinViewModule],
  data () {
    return {
      defaultProps: {
        children: 'children',
        label: 'name'
      },
      mixinViewModuleOptions: {
        getDataListURL: '/file/filemenu/page',
        getDataListIsPage:true,
        createdIsNeed:false,
      },
      dataForm: {
      },
      dataList1:[],
      isShowDownload:false,
      isShowPreview:false,
      isShowAdd:false,
      tableHeight:window.innerHeight*0.7,
      menuName:'',
    }
  },
  watch: {
  },
  mounted:function(){
    this.getMenu();
  },
  components: {
    AddOrUpdate,
  },
  methods: {
    getMenu(){
      this.$http.get('/file/filemenu/getFileMenu').then(({ data: res }) => {
        if (res.code != 0) {
          return this.$message.error(res.msg)
        }
        this.dataList1 = res.data
      })
    },
    getFill(node,data,value){
      this.isShowPreview = false;
      this.isShowDownload = false;
      this.isShowAdd = false;
      if(node.fileMenuAuth == 0){
        this.dataList = [];
        return this.$message.info("没有权限！")
      }else if(node.fileMenuAuth == 1){
        this.isShowPreview = true;
      }else if(node.fileMenuAuth == 2){
        this.isShowPreview = true;
        this.isShowDownload = true;
      }else if(node.fileMenuAuth == 3){
        this.isShowPreview = true;
        this.isShowDownload = true;
        this.isShowAdd = true;
      }
      this.dataForm.menuid = node.id;
      this.menuName = node.name
      this.getDataList();
    },
    download(){
      if(this.dataListSelections.length<1){
        this.$message.info("请选择要下载的文件");
      }
      let ids='';
      this.dataListSelections.forEach(item =>{
         ids+=item.id+',';
      });
      var params = qs.stringify({
        'token': Cookies.get('token'),
        'ids':ids,
        'menuName':this.menuName+this.dataForm.menuid,
      })
      window.location.href = `${window.SITE_CONFIG['apiURL']}/file/fileinfo/downloadfile?${params}`;
    },
    preview(){
      var params = qs.stringify({
        'token': Cookies.get('token'),
        'id':this.dataListSelections[0].id,
        'menuName':this.menuName+this.dataForm.menuid,
      })
      window.open('/renren-admin/static/pdf/web/viewer.html?file=' + encodeURIComponent(`${window.SITE_CONFIG['apiURL']}/file/fileinfo/getPDFByFileId?${params}`));
    },
  }
}
</script>
