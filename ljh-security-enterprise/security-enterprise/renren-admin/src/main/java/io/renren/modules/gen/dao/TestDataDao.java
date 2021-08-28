package io.renren.modules.gen.dao;

import io.renren.common.dao.BaseDao;
import io.renren.modules.gen.entity.TestDataEntity;
import org.apache.ibatis.annotations.Mapper;

/**
* 测试功能
*
* @author Mark
* @since 3.0 2020-12-01
*/
@Mapper
public interface TestDataDao extends BaseDao<TestDataEntity> {
	
}