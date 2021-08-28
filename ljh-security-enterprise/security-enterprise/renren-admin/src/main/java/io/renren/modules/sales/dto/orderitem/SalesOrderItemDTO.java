package io.renren.modules.sales.dto.orderitem;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* 订单字表
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Data
@ApiModel(value = "订单字表")
public class SalesOrderItemDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    @ApiModelProperty(value = "销售订单id")
    private Long salesOrderId;
    @ApiModelProperty(value = "行号")
    private Integer lineNum;
    @ApiModelProperty(value = "产品编码")
    private String productCode;
    @ApiModelProperty(value = "数量")
    private Integer qty;
    @ApiModelProperty(value = "需求日期")
    private Date needDate;
    @ApiModelProperty(value = "计划完成日期")
    private Date planFinishDate;
    @ApiModelProperty(value = "备注")
    private String remark;
    @ApiModelProperty(value = "创建人")
    private Long creator;
    @ApiModelProperty(value = "创建时间")
    private Date createDate;

}