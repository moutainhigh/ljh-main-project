package io.renren.modules.gen.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* 测试功能
*
* @author Mark
* @since 3.0 2020-12-01
*/
@Data
@ApiModel(value = "测试功能")
public class TestDataDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id")
    private Long id;
    @ApiModelProperty(value = "用户名")
    private String username;
    @ApiModelProperty(value = "姓名")
    private String realName;
    @ApiModelProperty(value = "性别")
    private Integer gender;
    @ApiModelProperty(value = "邮箱")
    private String email;
    @ApiModelProperty(value = "类型")
    private Integer noticeType;
    @ApiModelProperty(value = "内容")
    private String content;
    @ApiModelProperty(value = "创建者")
    private Long creator;
    @ApiModelProperty(value = "创建时间")
    private Date createDate;
    @ApiModelProperty(value = "更新者")
    private Long updater;
    @ApiModelProperty(value = "更新时间")
    private Date updateDate;

}