package io.renren.modules.basics.dto.product;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* 产品编码
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Data
@ApiModel(value = "产品编码")
public class ProductCodeDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    @ApiModelProperty(value = "编码")
    private String code;
    @ApiModelProperty(value = "产品名称")
    private String productName;
    @ApiModelProperty(value = "产品图号")
    private String drawingNum;
    @ApiModelProperty(value = "图号版本")
    private String drawingRev;
    @ApiModelProperty(value = "材质名称")
    private String materialName;
    @ApiModelProperty(value = "物料号")
    private String materialCodeNum;
    @ApiModelProperty(value = "备注")
    private String remark;
    @ApiModelProperty(value = "附件")
    private String attachment;
    @ApiModelProperty(value = "创建人")
    private Long creator;
    @ApiModelProperty(value = "创建时间")
    private Date createDate;
    @ApiModelProperty(value = "状态")
    private String state;

}