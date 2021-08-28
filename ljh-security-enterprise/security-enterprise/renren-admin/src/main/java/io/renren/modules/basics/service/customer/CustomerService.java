package io.renren.modules.basics.service.customer;

import io.renren.common.service.CrudService;
import io.renren.modules.basics.dto.customer.CustomerDTO;
import io.renren.modules.basics.entity.customer.CustomerEntity;

/**
 * 客户信息
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
public interface CustomerService extends CrudService<CustomerEntity, CustomerDTO> {

}