package io.renren.modules.basics.service.product.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.constant.Constant;
import io.renren.modules.basics.dao.product.ProductCodeDao;
import io.renren.modules.basics.dto.product.ProductCodeDTO;
import io.renren.modules.basics.entity.product.ProductCodeEntity;
import io.renren.modules.basics.service.product.ProductCodeService;
import io.renren.modules.security.user.SecurityUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * 产品编码
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Service
public class ProductCodeServiceImpl extends CrudServiceImpl<ProductCodeDao, ProductCodeEntity, ProductCodeDTO> implements ProductCodeService {

    @Override
    public QueryWrapper<ProductCodeEntity> getWrapper(Map<String, Object> params){
        QueryWrapper<ProductCodeEntity> wrapper = new QueryWrapper<>();

        String code = (String)params.get("code");
        wrapper.like(StringUtils.isNotBlank(code), "code", code);
        String productName = (String)params.get("productName");
        wrapper.like(StringUtils.isNotBlank(productName), "product_name", productName);
        String drawingNum = (String)params.get("drawingNum");
        wrapper.like(StringUtils.isNotBlank(drawingNum), "drawing_num", drawingNum);
        String drawingRev = (String)params.get("drawingRev");
        wrapper.like(StringUtils.isNotBlank(drawingRev), "drawing_rev", drawingRev);
        String materialName = (String)params.get("materialName");
        wrapper.like(StringUtils.isNotBlank(materialName), "material_name", materialName);
        String materialCodeNum = (String)params.get("materialCodeNum");
        wrapper.like(StringUtils.isNotBlank(materialCodeNum), "material_code_num", materialCodeNum);

        return wrapper;
    }


}