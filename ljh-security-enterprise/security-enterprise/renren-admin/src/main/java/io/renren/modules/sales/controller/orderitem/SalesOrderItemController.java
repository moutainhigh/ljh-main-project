package io.renren.modules.sales.controller.orderitem;

import io.renren.common.annotation.LogOperation;
import io.renren.common.constant.Constant;
import io.renren.common.page.PageData;
import io.renren.common.utils.ExcelUtils;
import io.renren.common.utils.Result;
import io.renren.common.validator.AssertUtils;
import io.renren.common.validator.ValidatorUtils;
import io.renren.common.validator.group.AddGroup;
import io.renren.common.validator.group.DefaultGroup;
import io.renren.common.validator.group.UpdateGroup;
import io.renren.modules.sales.dto.orderitem.SalesOrderItemDTO;
import io.renren.modules.sales.excel.orderitem.SalesOrderItemExcel;
import io.renren.modules.sales.service.orderitem.SalesOrderItemService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;


/**
* 订单字表
*
* @author Mark
* @since 3.0 2020-12-14
*/
@RestController
@RequestMapping("sales/salesorderitem")
@Api(tags="订单字表")
public class SalesOrderItemController {
    @Autowired
    private SalesOrderItemService salesOrderItemService;

    @GetMapping("page")
    @ApiOperation("分页")
    @ApiImplicitParams({
        @ApiImplicitParam(name = Constant.PAGE, value = "当前页码，从1开始", paramType = "query", required = true, dataType="int") ,
        @ApiImplicitParam(name = Constant.LIMIT, value = "每页显示记录数", paramType = "query",required = true, dataType="int") ,
        @ApiImplicitParam(name = Constant.ORDER_FIELD, value = "排序字段", paramType = "query", dataType="String") ,
        @ApiImplicitParam(name = Constant.ORDER, value = "排序方式，可选值(asc、desc)", paramType = "query", dataType="String")
    })
    @RequiresPermissions("sales:salesorderitem:page")
    public Result<PageData<SalesOrderItemDTO>> page(@ApiIgnore @RequestParam Map<String, Object> params){
        PageData<SalesOrderItemDTO> page = salesOrderItemService.page(params);

        return new Result<PageData<SalesOrderItemDTO>>().ok(page);
    }

    @GetMapping("{id}")
    @ApiOperation("信息")
    @RequiresPermissions("sales:salesorderitem:info")
    public Result<SalesOrderItemDTO> get(@PathVariable("id") Long id){
        SalesOrderItemDTO data = salesOrderItemService.get(id);

        return new Result<SalesOrderItemDTO>().ok(data);
    }

    @PostMapping
    @ApiOperation("保存")
    @LogOperation("保存")
    @RequiresPermissions("sales:salesorderitem:save")
    public Result save(@RequestBody SalesOrderItemDTO dto){
        //效验数据
        ValidatorUtils.validateEntity(dto, AddGroup.class, DefaultGroup.class);

        salesOrderItemService.save(dto);

        return new Result();
    }

    @PutMapping
    @ApiOperation("修改")
    @LogOperation("修改")
    @RequiresPermissions("sales:salesorderitem:update")
    public Result update(@RequestBody SalesOrderItemDTO dto){
        //效验数据
        ValidatorUtils.validateEntity(dto, UpdateGroup.class, DefaultGroup.class);

        salesOrderItemService.update(dto);

        return new Result();
    }

    @DeleteMapping
    @ApiOperation("删除")
    @LogOperation("删除")
    @RequiresPermissions("sales:salesorderitem:delete")
    public Result delete(@RequestBody Long[] ids){
        //效验数据
        AssertUtils.isArrayEmpty(ids, "id");

        salesOrderItemService.delete(ids);

        return new Result();
    }

    @GetMapping("export")
    @ApiOperation("导出")
    @LogOperation("导出")
    @RequiresPermissions("sales:salesorderitem:export")
    public void export(@ApiIgnore @RequestParam Map<String, Object> params, HttpServletResponse response) throws Exception {
        List<SalesOrderItemDTO> list = salesOrderItemService.list(params);

        ExcelUtils.exportExcelToTarget(response, null, "订单字表", list, SalesOrderItemExcel.class);
    }

}