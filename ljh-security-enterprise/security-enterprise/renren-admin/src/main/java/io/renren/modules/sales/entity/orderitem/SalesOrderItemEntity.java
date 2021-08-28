package io.renren.modules.sales.entity.orderitem;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;
import java.util.Date;
import io.renren.common.entity.BaseEntity;

/**
 * 订单字表
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("sales_order_item")
public class SalesOrderItemEntity extends BaseEntity {
	private static final long serialVersionUID = 1L;

	/**
	* 销售订单id
	*/
	private Long salesOrderId;
	/**
	* 行号
	*/
	private Integer lineNum;
	/**
	* 产品编码
	*/
	private String productCode;
	/**
	* 数量
	*/
	private Integer qty;
	/**
	* 需求日期
	*/
	private Date needDate;
	/**
	* 计划完成日期
	*/
	private Date planFinishDate;
	/**
	* 备注
	*/
	private String remark;
}