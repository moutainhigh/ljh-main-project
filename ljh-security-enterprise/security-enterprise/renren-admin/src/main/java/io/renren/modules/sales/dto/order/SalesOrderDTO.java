package io.renren.modules.sales.dto.order;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* 销售订单
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Data
@ApiModel(value = "销售订单")
public class SalesOrderDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    @ApiModelProperty(value = "销售订单号")
    private String salesOrderNum;
    @ApiModelProperty(value = "客户订单号")
    private String customerPurchaseNum;
    @ApiModelProperty(value = "客户")
    private Long customerId;
    @ApiModelProperty(value = "币种")
    private Long currencyId;
    @ApiModelProperty(value = "备注")
    private String remark;
    @ApiModelProperty(value = "附件")
    private String attachment;
    @ApiModelProperty(value = "流程实例Id")
    private String instanceId;
    @ApiModelProperty(value = "状态")
    private String state;
    @ApiModelProperty(value = "创建人")
    private Long creator;
    @ApiModelProperty(value = "创建时间")
    private Date createDate;
    @ApiModelProperty(value = "修改人")
    private Long updater;
    @ApiModelProperty(value = "修改时间")
    private Date updateDate;

}