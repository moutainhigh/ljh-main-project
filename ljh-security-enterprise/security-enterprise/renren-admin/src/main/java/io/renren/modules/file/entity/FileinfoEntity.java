package io.renren.modules.file.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
import java.util.Date;
import io.renren.common.entity.BaseEntity;

/**
 * 文件
 *
 * @author Mark
 * @since 3.0 2020-12-02
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("fileinfo")
public class FileinfoEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	* 文件id
	*/
	private Integer fileid;
	/**
	* 文件名称
	*/
	private String filename;
	/**
	* 菜单编号
	*/
	private Long menuid;
	/**
	* 备注
	*/
	private String remark;
	/**
	* 版本
	*/
	private String revision;
	/**
	* 是否有效
	*/
	private Integer effective;
	/**
	* 文件格式
	*/
	private String format;
	/**
	* 文件大小
	*/
	private Integer size;
	/**
	* 文件编号
	*/
	private String filenum;
	/**
	* 管理备注
	*/
	private String mgtremark;
	/**
	* 标准状态
	*/
	private String stdstate;
	/**
	* 修改人
	*/
	@TableField(fill = FieldFill.INSERT_UPDATE)
	private Date updater;
	/**
	* 修改时间
	*/
	private Date updatedate;
}