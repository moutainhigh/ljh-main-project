package io.renren.modules.demo.dao;

import io.renren.common.dao.BaseDao;
import io.renren.modules.demo.entity.ProductEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 产品管理
 *
 * @author Mark
 */
@Mapper
public interface ProductDao extends BaseDao<ProductEntity> {
	
}