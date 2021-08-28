package io.renren.modules.sales.service.orderitem.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.constant.Constant;
import io.renren.modules.sales.dao.orderitem.SalesOrderItemDao;
import io.renren.modules.sales.dto.orderitem.SalesOrderItemDTO;
import io.renren.modules.sales.entity.orderitem.SalesOrderItemEntity;
import io.renren.modules.sales.service.orderitem.SalesOrderItemService;
import io.renren.modules.security.user.SecurityUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 订单字表
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Service
public class SalesOrderItemServiceImpl extends CrudServiceImpl<SalesOrderItemDao, SalesOrderItemEntity, SalesOrderItemDTO> implements SalesOrderItemService {

    @Override
    public QueryWrapper<SalesOrderItemEntity> getWrapper(Map<String, Object> params){
        QueryWrapper<SalesOrderItemEntity> wrapper = new QueryWrapper<>();

        String salesOrderId = (String)params.get("salesOrderId");
        wrapper.like(StringUtils.isNotBlank(salesOrderId), "sales_order_id", salesOrderId);
        String productCode = (String)params.get("productCode");
        wrapper.like(StringUtils.isNotBlank(productCode), "product_code", productCode);

        return wrapper;
    }


}