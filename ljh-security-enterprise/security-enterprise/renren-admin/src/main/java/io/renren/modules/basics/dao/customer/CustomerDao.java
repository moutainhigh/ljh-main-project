package io.renren.modules.basics.dao.customer;

import io.renren.common.dao.BaseDao;
import io.renren.modules.basics.entity.customer.CustomerEntity;
import org.apache.ibatis.annotations.Mapper;

/**
* 客户信息
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Mapper
public interface CustomerDao extends BaseDao<CustomerEntity> {
	
}