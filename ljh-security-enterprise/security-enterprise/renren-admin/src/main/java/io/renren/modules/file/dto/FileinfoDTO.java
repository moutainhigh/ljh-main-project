package io.renren.modules.file.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* 文件
*
* @author Mark
* @since 3.0 2020-12-02
*/
@Data
@ApiModel(value = "文件")
public class FileinfoDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "主键")
    private Long id;
    @ApiModelProperty(value = "文件id")
    private Integer fileid;
    @ApiModelProperty(value = "文件名称")
    private String filename;
    @ApiModelProperty(value = "菜单编号")
    private Long menuid;
    @ApiModelProperty(value = "备注")
    private String remark;
    @ApiModelProperty(value = "版本")
    private String revision;
    @ApiModelProperty(value = "是否有效")
    private Integer effective;
    @ApiModelProperty(value = "文件格式")
    private String format;
    @ApiModelProperty(value = "文件大小")
    private Integer size;
    @ApiModelProperty(value = "文件编号")
    private String filenum;
    @ApiModelProperty(value = "管理备注")
    private String mgtremark;
    @ApiModelProperty(value = "标准状态")
    private String stdstate;
    @ApiModelProperty(value = "修改人")
    private Date updater;
    @ApiModelProperty(value = "修改时间")
    private Date updatedate;
    @ApiModelProperty(value = "创建人")
    private String creator;
    @ApiModelProperty(value = "创建时间")
    private Date createDate;

}