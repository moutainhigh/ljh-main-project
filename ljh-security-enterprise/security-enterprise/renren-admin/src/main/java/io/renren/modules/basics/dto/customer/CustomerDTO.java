package io.renren.modules.basics.dto.customer;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* 客户信息
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Data
@ApiModel(value = "客户信息")
public class CustomerDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    @ApiModelProperty(value = "名称")
    private String customerName;
    @ApiModelProperty(value = "简称")
    private String nameAbb;
    @ApiModelProperty(value = "国别")
    private String country;
    @ApiModelProperty(value = "地址")
    private String address;
    @ApiModelProperty(value = "联系人")
    private String contactPerson;
    @ApiModelProperty(value = "附件")
    private String attachment;
    @ApiModelProperty(value = "备注")
    private String remark;
    @ApiModelProperty(value = "状态")
    private String state;
    @ApiModelProperty(value = "创建人")
    private Long creator;
    @ApiModelProperty(value = "创建时间")
    private Date createDate;

}