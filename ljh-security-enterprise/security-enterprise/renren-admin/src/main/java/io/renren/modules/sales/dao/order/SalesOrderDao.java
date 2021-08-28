package io.renren.modules.sales.dao.order;

import io.renren.common.dao.BaseDao;
import io.renren.modules.sales.entity.order.SalesOrderEntity;
import org.apache.ibatis.annotations.Mapper;

/**
* 销售订单
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Mapper
public interface SalesOrderDao extends BaseDao<SalesOrderEntity> {
    void updateInstanceId(String processInstanceId,Long Id);
}