package io.renren.modules.basics.dao.product;

import io.renren.common.dao.BaseDao;
import io.renren.modules.basics.entity.product.ProductCodeEntity;
import org.apache.ibatis.annotations.Mapper;

/**
* 产品编码
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Mapper
public interface ProductCodeDao extends BaseDao<ProductCodeEntity> {
	
}