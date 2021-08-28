package io.renren.modules.gen.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.constant.Constant;
import io.renren.modules.gen.dao.TestDataDao;
import io.renren.modules.gen.dto.TestDataDTO;
import io.renren.modules.gen.entity.TestDataEntity;
import io.renren.modules.gen.service.TestDataService;
import io.renren.modules.security.user.SecurityUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 测试功能
 *
 * @author Mark
 * @since 3.0 2020-12-01
 */
@Service
public class TestDataServiceImpl extends CrudServiceImpl<TestDataDao, TestDataEntity, TestDataDTO> implements TestDataService {

    @Override
    public QueryWrapper<TestDataEntity> getWrapper(Map<String, Object> params){
        QueryWrapper<TestDataEntity> wrapper = new QueryWrapper<>();

        String username = (String)params.get("username");
        wrapper.like(StringUtils.isNotBlank(username), "username", username);
        String gender = (String)params.get("gender");
        wrapper.eq(StringUtils.isNotBlank(gender), "gender", gender);
        String startDate = (String)params.get("startDate");
        String endDate = (String)params.get("endDate");
        wrapper.ge(StringUtils.isNotBlank(startDate), "create_date", startDate);
        wrapper.le(StringUtils.isNotBlank(endDate), "create_date", endDate);

        return wrapper;
    }


}