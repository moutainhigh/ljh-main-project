package io.renren.modules.basics.service.currency.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.constant.Constant;
import io.renren.modules.basics.dao.currency.CurrencyDao;
import io.renren.modules.basics.dto.currency.CurrencyDTO;
import io.renren.modules.basics.entity.currency.CurrencyEntity;
import io.renren.modules.basics.service.currency.CurrencyService;
import io.renren.modules.security.user.SecurityUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 币种
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Service
public class CurrencyServiceImpl extends CrudServiceImpl<CurrencyDao, CurrencyEntity, CurrencyDTO> implements CurrencyService {

    @Override
    public QueryWrapper<CurrencyEntity> getWrapper(Map<String, Object> params){
        QueryWrapper<CurrencyEntity> wrapper = new QueryWrapper<>();


        return wrapper;
    }


}