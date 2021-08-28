package io.renren.modules.sales.entity.order;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
import java.util.Date;
import io.renren.common.entity.BaseEntity;

/**
 * 销售订单
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("sales_order")
public class SalesOrderEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	* 销售订单号
	*/
	private String salesOrderNum;
	/**
	* 客户订单号
	*/
	private String customerPurchaseNum;
	/**
	* 客户
	*/
	private Long customerId;
	/**
	* 币种
	*/
	private Long currencyId;
	/**
	* 备注
	*/
	private String remark;
	/**
	* 附件
	*/
	private String attachment;
	/**
	 * 流程实例id
	 */
	private String instanceId;
	/**
	* 状态
	*/
	private String state;
	/**
	* 修改人
	*/
	@TableField(fill = FieldFill.INSERT_UPDATE)
	private Long updater;
	/**
	* 修改时间
	*/
	@TableField(fill = FieldFill.INSERT_UPDATE)
	private Date updateDate;
}