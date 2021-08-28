package io.renren.modules.file.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
import java.util.Date;
import io.renren.common.entity.BaseEntity;

/**
 * 文件管理
 *
 * @author Mark
 * @since 3.0 2020-12-01
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("filemenu")
public class FilemenuEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	* 目录文件名称
	*/
	private String name;
	/**
	* 父id
	*/
	private Long parentid;
}