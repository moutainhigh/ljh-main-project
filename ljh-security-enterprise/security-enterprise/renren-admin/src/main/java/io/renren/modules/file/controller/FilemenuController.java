package io.renren.modules.file.controller;

import io.renren.common.annotation.LogOperation;
import io.renren.common.constant.Constant;
import io.renren.common.exception.ErrorCode;
import io.renren.common.page.PageData;
import io.renren.common.utils.ExcelUtils;
import io.renren.common.utils.Result;
import io.renren.common.validator.AssertUtils;
import io.renren.common.validator.ValidatorUtils;
import io.renren.common.validator.group.AddGroup;
import io.renren.common.validator.group.DefaultGroup;
import io.renren.common.validator.group.UpdateGroup;
import io.renren.modules.file.dto.FileinfoDTO;
import io.renren.modules.file.dto.FilemenuDTO;
import io.renren.modules.file.excel.FilemenuExcel;
import io.renren.modules.file.service.FileinfoService;
import io.renren.modules.file.service.FilemenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;


/**
* 文件管理
*
* @author Mark
* @since 3.0 2020-12-01
*/
@RestController
@RequestMapping("file/filemenu")
@Api(tags="文件管理")
public class FilemenuController {
    @Autowired
    private FilemenuService filemenuService;
    @Autowired
    private FileinfoService fileinfoService;

    @GetMapping("page")
    @ApiOperation("分页")
    @ApiImplicitParams({
        @ApiImplicitParam(name = Constant.PAGE, value = "当前页码，从1开始", paramType = "query", required = true, dataType="int") ,
        @ApiImplicitParam(name = Constant.LIMIT, value = "每页显示记录数", paramType = "query",required = true, dataType="int") ,
        @ApiImplicitParam(name = Constant.ORDER_FIELD, value = "排序字段", paramType = "query", dataType="String") ,
        @ApiImplicitParam(name = Constant.ORDER, value = "排序方式，可选值(asc、desc)", paramType = "query", dataType="String")
    })
    public Result<PageData<FileinfoDTO>> page(@ApiIgnore @RequestParam Map<String, Object> params){
        PageData<FileinfoDTO> page = fileinfoService.page(params);

        return new Result<PageData<FileinfoDTO>>().ok(page);
    }
    @GetMapping("getFileMenu")
    @ApiOperation("菜单树")
    public Result<List<FilemenuDTO>> getFileMenu(){
        List<FilemenuDTO> filemenuDTOS = filemenuService.getTreeData();

        return new Result<List<FilemenuDTO>>().ok(filemenuDTOS);
    }

    @GetMapping("getFileMenuByRoleId/{roleId}")
    @ApiOperation("菜单树")
    public Result<List<FilemenuDTO>> getFileMenuByRoleId(@PathVariable("roleId")Long roleId){
        List<FilemenuDTO> filemenuDTOS = filemenuService.getTreeDataByRoleId(roleId);

        return new Result<List<FilemenuDTO>>().ok(filemenuDTOS);
    }
    @GetMapping("{id}")
    @ApiOperation("信息")
    @RequiresPermissions("file:filemenu:info")
    public Result<FilemenuDTO> get(@PathVariable("id") Long id){
        FilemenuDTO data = filemenuService.get(id);

        return new Result<FilemenuDTO>().ok(data);
    }

    @PostMapping
    @ApiOperation("保存")
    @LogOperation("保存")
    public Result save(@RequestBody FilemenuDTO dto){
        //效验数据
        ValidatorUtils.validateEntity(dto, AddGroup.class, DefaultGroup.class);

        filemenuService.save(dto);

        return new Result();
    }

    @PutMapping
    @ApiOperation("修改")
    @LogOperation("修改")
    @RequiresPermissions("file:filemenu:update")
    public Result update(@RequestBody FilemenuDTO dto){
        //效验数据
        ValidatorUtils.validateEntity(dto, UpdateGroup.class, DefaultGroup.class);

        filemenuService.update(dto);

        return new Result();
    }

    @DeleteMapping
    @ApiOperation("删除")
    @LogOperation("删除")
    @RequiresPermissions("file:filemenu:delete")
    public Result delete(@RequestBody Long[] ids){
        //效验数据
        AssertUtils.isArrayEmpty(ids, "id");

        filemenuService.delete(ids);

        return new Result();
    }

    @GetMapping("export")
    @ApiOperation("导出")
    @LogOperation("导出")
    @RequiresPermissions("file:filemenu:export")
    public void export(@ApiIgnore @RequestParam Map<String, Object> params, HttpServletResponse response) throws Exception {
        List<FilemenuDTO> list = filemenuService.list(params);

        ExcelUtils.exportExcelToTarget(response, null, "文件管理", list, FilemenuExcel.class);
    }

}