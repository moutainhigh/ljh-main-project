package io.renren.modules.sales.service.order.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.constant.Constant;
import io.renren.modules.sales.dao.order.SalesOrderDao;
import io.renren.modules.sales.dto.order.SalesOrderDTO;
import io.renren.modules.sales.entity.order.SalesOrderEntity;
import io.renren.modules.sales.service.order.SalesOrderService;
import io.renren.modules.security.user.SecurityUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 销售订单
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Service
public class SalesOrderServiceImpl extends CrudServiceImpl<SalesOrderDao, SalesOrderEntity, SalesOrderDTO> implements SalesOrderService {

    @Override
    public QueryWrapper<SalesOrderEntity> getWrapper(Map<String, Object> params){
        QueryWrapper<SalesOrderEntity> wrapper = new QueryWrapper<>();

        String salesOrderNum = (String)params.get("salesOrderNum");
        wrapper.like(StringUtils.isNotBlank(salesOrderNum), "sales_order_num", salesOrderNum);
        String customerPurchaseNum = (String)params.get("customerPurchaseNum");
        wrapper.like(StringUtils.isNotBlank(customerPurchaseNum), "customer_purchase_num", customerPurchaseNum);
        String customerId = (String)params.get("customerId");
        wrapper.eq(StringUtils.isNotBlank(customerId), "customer_id", customerId);

        return wrapper;
    }


    @Override
    public void updateInstanceId(String processInstanceId, Long Id) {
        baseDao.updateInstanceId(processInstanceId,Id);
    }
}