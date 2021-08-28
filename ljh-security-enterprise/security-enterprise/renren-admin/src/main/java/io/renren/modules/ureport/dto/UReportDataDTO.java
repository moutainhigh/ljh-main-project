/**
 * Copyright (c) 2020 人人开源 All rights reserved.
 * <p>
 * https://www.renren.io
 * <p>
 * 版权所有，侵权必究！
 */
package io.renren.modules.ureport.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 报表管理
 *
 * @author Mark
 */
@Data
@ApiModel(value = "报表管理")
public class UReportDataDTO implements Serializable {
    @ApiModelProperty(value = "id")
    private Long id;
    @ApiModelProperty(value = "报表文件名")
    private String fileName;
    @ApiModelProperty(value = "更新时间")
    private Date updateDate;
    @ApiModelProperty(value = "创建时间")
    private Date createDate;
}
