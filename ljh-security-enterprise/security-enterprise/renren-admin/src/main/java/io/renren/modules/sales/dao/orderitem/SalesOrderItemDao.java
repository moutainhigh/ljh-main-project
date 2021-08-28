package io.renren.modules.sales.dao.orderitem;

import io.renren.common.dao.BaseDao;
import io.renren.modules.sales.entity.orderitem.SalesOrderItemEntity;
import org.apache.ibatis.annotations.Mapper;

/**
* 订单字表
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Mapper
public interface SalesOrderItemDao extends BaseDao<SalesOrderItemEntity> {
	
}