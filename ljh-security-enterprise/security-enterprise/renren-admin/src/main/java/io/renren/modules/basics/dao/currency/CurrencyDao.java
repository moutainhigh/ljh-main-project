package io.renren.modules.basics.dao.currency;

import io.renren.common.dao.BaseDao;
import io.renren.modules.basics.entity.currency.CurrencyEntity;
import org.apache.ibatis.annotations.Mapper;

/**
* 币种
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Mapper
public interface CurrencyDao extends BaseDao<CurrencyEntity> {
	
}