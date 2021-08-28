package io.renren.modules.basics.entity.product;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
import java.util.Date;
import io.renren.common.entity.BaseEntity;

/**
 * 产品编码
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("product_code")
public class ProductCodeEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	* 编码
	*/
	private String code;
	/**
	* 产品名称
	*/
	private String productName;
	/**
	* 产品图号
	*/
	private String drawingNum;
	/**
	* 图号版本
	*/
	private String drawingRev;
	/**
	* 材质名称
	*/
	private String materialName;
	/**
	* 物料号
	*/
	private String materialCodeNum;
	/**
	* 备注
	*/
	private String remark;
	/**
	* 附件
	*/
	private String attachment;
	/**
	* 状态
	*/
	private String state;
}