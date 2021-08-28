package io.renren.modules.basics.service.customer.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.constant.Constant;
import io.renren.modules.basics.dao.customer.CustomerDao;
import io.renren.modules.basics.dto.customer.CustomerDTO;
import io.renren.modules.basics.entity.customer.CustomerEntity;
import io.renren.modules.basics.service.customer.CustomerService;
import io.renren.modules.security.user.SecurityUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 客户信息
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Service
public class CustomerServiceImpl extends CrudServiceImpl<CustomerDao, CustomerEntity, CustomerDTO> implements CustomerService {

    @Override
    public QueryWrapper<CustomerEntity> getWrapper(Map<String, Object> params){
        QueryWrapper<CustomerEntity> wrapper = new QueryWrapper<>();

        String customerName = (String)params.get("customerName");
        wrapper.like(StringUtils.isNotBlank(customerName), "customer_name", customerName);
        String nameAbb = (String)params.get("nameAbb");
        wrapper.like(StringUtils.isNotBlank(nameAbb), "name_abb", nameAbb);

        return wrapper;
    }


}