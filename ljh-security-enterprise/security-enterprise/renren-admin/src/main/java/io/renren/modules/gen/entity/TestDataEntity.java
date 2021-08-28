package io.renren.modules.gen.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
import java.util.Date;
import io.renren.common.entity.BaseEntity;

/**
 * 测试功能
 *
 * @author Mark
 * @since 3.0 2020-12-01
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("gen_test_data")
public class TestDataEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	* 用户名
	*/
	private String username;
	/**
	* 姓名
	*/
	private String realName;
	/**
	* 性别
	*/
	private Integer gender;
	/**
	* 邮箱
	*/
	private String email;
	/**
	* 类型
	*/
	private Integer noticeType;
	/**
	* 内容
	*/
	private String content;
	/**
	* 更新者
	*/
	@TableField(fill = FieldFill.INSERT_UPDATE)
	private Long updater;
	/**
	* 更新时间
	*/
	@TableField(fill = FieldFill.INSERT_UPDATE)
	private Date updateDate;
}