package io.renren.modules.sales.service.order;

import io.renren.common.service.CrudService;
import io.renren.modules.sales.dto.order.SalesOrderDTO;
import io.renren.modules.sales.entity.order.SalesOrderEntity;

/**
 * 销售订单
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
public interface SalesOrderService extends CrudService<SalesOrderEntity, SalesOrderDTO> {

    void updateInstanceId(String processInstanceId,Long Id);
}