<template>
  <el-container style=" border: 1px solid #eee">
    <el-aside width="600px" style="background-color: rgb(238, 241, 246)">
      <el-table v-loading="dataListLoading"
                :data="roleData"
                highlight-current-row
                @current-change="handleCurrentChange"
                border style="width: 100%;">
        <el-table-column prop="name" label="角色名称" header-align="center" align="center"></el-table-column>
      </el-table>
    </el-aside>
    <el-aside width="600px" style="background-color: rgb(238, 241, 246)">
      <el-card shadow="never" class="aui-card--fill">
        <el-button @click="saveFileMenuAuth" type="primary">保存</el-button>
        <el-button type="primary" @click="addOrUpdateHandle()">{{ $t('add') }}</el-button>
        <div class="custom-tree-container">
          <div class="block">
            <el-tree
                    :data="this.fileMenuData"
                    :props="this.defaultProps"
                    @node-click="treeClick"
                    :expand-on-click-node="this.expandTree"
                    node-key="id">
              <span class="custom-tree-node" slot-scope="{ node, data }">
        <span>{{ node.label }}</span>
        <span>
          <el-radio-group @change="radioChange" v-model="data.fileMenuAuth">
            <el-radio :label="0">无权限</el-radio>
            <el-radio :label="1">只读</el-radio>
            <el-radio :label="2">下载</el-radio>
            <el-radio :label="3">编辑</el-radio>
          </el-radio-group>
        </span>
      </span>
            </el-tree>
          </div>
        </div>
        <add-or-update :role-id="this.roleId" :menu-id="this.treeId" :menu-name="this.treeName" ref="addOrUpdate" @refreshDataList="getFileMenuData"></add-or-update>
      </el-card>
    </el-aside>
  </el-container>
</template>

<script>
import mixinViewModule from '@/mixins/view-module'
import AddOrUpdate from './filemenu-add-or-update'
import debounce from "lodash/debounce";
export default {
  mixins: [mixinViewModule],
  data () {
    return {
      defaultProps: {
        children: 'children',
        label: 'name'
      },
      mixinViewModuleOptions: {
        getDataListURL: '/file/filemenurole/fileMenuRoleList'
      },
      dataForm: {
      },
      expandTree:false,
      fileMenuData:[],
      roleData:[],
      roleId:0,
      radio: 0,
      treeId:0,
      treeName:'',
    }
  },
  watch: {
  },
  mounted:function(){
    this.getFileMenuData();
    this.getRoleData();
  },
  components: {
    AddOrUpdate
  },
  methods: {
    handleCurrentChange(val){
      this.roleId = val.id;
      this.$http.get(`/file/filemenu/getFileMenuByRoleId/${val.id}`).then(({ data: res }) => {
        if (res.code !== 0) {
          return this.$message.error(res.msg)
        }
        this.fileMenuData = res.data
      })

    },
    getFileMenuData(){
      this.$http.get('/file/filemenu/getFileMenu').then(({ data: res }) => {
        if (res.code !== 0) {
          return this.$message.error(res.msg)
        }
        this.fileMenuData = res.data
      })
    },
    getRoleData(){
      this.$http.get('/sys/role/list').then(({ data: res }) => {
        if (res.code !== 0) {
          return this.$message.error(res.msg)
        }
        this.roleData = res.data
      })
    },
    treeClick(node,data,value){
      this.treeId = node.id;
      this.treeName = node.name;
    },
    updateChildren(val,treeMenu){
      debugger
      for(let i=0;i<treeMenu.length;i++){
        if(treeMenu[i].id == this.treeId){
          if(treeMenu[i].children!=null){
            this.updateRedioStatus(val,treeMenu[i].children);
          }
        }
        if(treeMenu[i].children!=null && treeMenu[i].children.length>0){
          this.updateChildren(val,treeMenu[i].children);
        }
      }
    },
    updateRedioStatus(val,treeMenu){
      if(treeMenu!=null && treeMenu.length>0){
        for(let i=0;i<treeMenu.length;i++){
          treeMenu[i].fileMenuAuth = val;
          this.updateRedioStatus(val,treeMenu[i].children);
        }
      }
    },
    radioChange(val){
      this.updateChildren(val,this.fileMenuData)
    },
    saveFileMenuAuth: debounce(function () {
      var params = new URLSearchParams();
      params.append('requestData', JSON.stringify(this.fileMenuData));
      params.append('roleId',this.roleId);
      this.$http['post']('/file/filemenurole/save', params).then(({ data: res }) => {
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
    }, 1000, { 'leading': true, 'trailing': false })
  }
}
</script>
