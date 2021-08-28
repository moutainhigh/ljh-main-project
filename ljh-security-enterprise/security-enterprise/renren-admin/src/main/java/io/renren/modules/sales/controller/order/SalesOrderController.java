package io.renren.modules.sales.controller.order;

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
import io.renren.modules.sales.dto.order.SalesOrderDTO;
import io.renren.modules.sales.excel.order.SalesOrderExcel;
import io.renren.modules.sales.service.order.SalesOrderService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
* 销售订单
*
* @author Mark
* @since 3.0 2020-12-14
*/
@RestController
@RequestMapping("sales/salesorder")
@Api(tags="销售订单")
public class SalesOrderController {
    @Autowired
    private SalesOrderService salesOrderService;

    @GetMapping("page")
    @ApiOperation("分页")
    @ApiImplicitParams({
        @ApiImplicitParam(name = Constant.PAGE, value = "当前页码，从1开始", paramType = "query", required = true, dataType="int") ,
        @ApiImplicitParam(name = Constant.LIMIT, value = "每页显示记录数", paramType = "query",required = true, dataType="int") ,
        @ApiImplicitParam(name = Constant.ORDER_FIELD, value = "排序字段", paramType = "query", dataType="String") ,
        @ApiImplicitParam(name = Constant.ORDER, value = "排序方式，可选值(asc、desc)", paramType = "query", dataType="String")
    })
    @RequiresPermissions("sales:salesorder:page")
    public Result<PageData<SalesOrderDTO>> page(@ApiIgnore @RequestParam Map<String, Object> params){
        PageData<SalesOrderDTO> page = salesOrderService.page(params);

        return new Result<PageData<SalesOrderDTO>>().ok(page);
    }

    @GetMapping("{id}")
    @ApiOperation("信息")
    @RequiresPermissions("sales:salesorder:info")
    public Result<SalesOrderDTO> get(@PathVariable("id") Long id){
        SalesOrderDTO data = salesOrderService.get(id);

        return new Result<SalesOrderDTO>().ok(data);
    }

    @PostMapping
    @ApiOperation("保存")
    @LogOperation("保存")
    @RequiresPermissions("sales:salesorder:save")
    public Result save(@RequestBody SalesOrderDTO dto){
        //效验数据
        ValidatorUtils.validateEntity(dto, AddGroup.class, DefaultGroup.class);

        salesOrderService.save(dto);
        Map<String, Object> map = new HashMap<>();
        map.put("businessKey", dto.getId().toString());
        return new Result().ok(map);
    }

    @PutMapping
    @ApiOperation("修改")
    @LogOperation("修改")
    @RequiresPermissions("sales:salesorder:update")
    public Result update(@RequestBody SalesOrderDTO dto){
        //效验数据
        ValidatorUtils.validateEntity(dto, UpdateGroup.class, DefaultGroup.class);

        salesOrderService.update(dto);

        return new Result();
    }

    @DeleteMapping
    @ApiOperation("删除")
    @LogOperation("删除")
    @RequiresPermissions("sales:salesorder:delete")
    public Result delete(@RequestBody Long[] ids){
        //效验数据
        AssertUtils.isArrayEmpty(ids, "id");

        salesOrderService.delete(ids);

        return new Result();
    }

    @GetMapping("export")
    @ApiOperation("导出")
    @LogOperation("导出")
    @RequiresPermissions("sales:salesorder:export")
    public void export(@ApiIgnore @RequestParam Map<String, Object> params, HttpServletResponse response) throws Exception {
        List<SalesOrderDTO> list = salesOrderService.list(params);

        ExcelUtils.exportExcelToTarget(response, null, "销售订单", list, SalesOrderExcel.class);
    }

    @PostMapping("updateInstanceId")
    @ApiOperation("更新实例ID")
    @LogOperation("更新实例ID")
    @RequiresPermissions("sales:salesorder:all")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "businessKey", value = "业务KEY", paramType = "query", required = true, dataType="String"),
            @ApiImplicitParam(name = "processInstanceId", value = "实例ID", paramType = "query",required = true, dataType="String")
    })
    public Result updateInstanceId(String businessKey, String processInstanceId){
        Long id = Long.valueOf(businessKey);
        salesOrderService.updateInstanceId(processInstanceId, id);
        return new Result();
    }

}