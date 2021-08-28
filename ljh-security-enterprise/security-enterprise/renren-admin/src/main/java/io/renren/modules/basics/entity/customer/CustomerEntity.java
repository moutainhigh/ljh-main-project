package io.renren.modules.basics.entity.customer;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
import java.util.Date;
import io.renren.common.entity.BaseEntity;

/**
 * 客户信息
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("customer")
public class CustomerEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	* 名称
	*/
	private String customerName;
	/**
	* 简称
	*/
	private String nameAbb;
	/**
	* 国别
	*/
	private String country;
	/**
	* 地址
	*/
	private String address;
	/**
	* 联系人
	*/
	private String contactPerson;
	/**
	* 附件
	*/
	private String attachment;
	/**
	* 备注
	*/
	private String remark;
	/**
	* 状态
	*/
	private String state;
}