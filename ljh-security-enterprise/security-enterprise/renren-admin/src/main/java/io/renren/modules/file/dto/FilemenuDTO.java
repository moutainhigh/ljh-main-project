package io.renren.modules.file.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
* 文件管理
*
* @author Mark
* @since 3.0 2020-12-01
*/
@Data
@ApiModel(value = "文件管理")
public class FilemenuDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id")
    private Long id;
    @ApiModelProperty(value = "目录文件名称")
    private String name;
    @ApiModelProperty(value = "父id")
    private Long parentid;
    @ApiModelProperty(value = "子节点")
    private List<FilemenuDTO> children;
    @ApiModelProperty(value = "权限")
    private Integer fileMenuAuth;
    @ApiModelProperty(value = "创建人")
    private Long creator;
    @ApiModelProperty(value = "创建时间")
    private Date createDate;

    public Integer getFileMenuAuth() {
    return fileMenuAuth!=null?fileMenuAuth:0;
    }
}