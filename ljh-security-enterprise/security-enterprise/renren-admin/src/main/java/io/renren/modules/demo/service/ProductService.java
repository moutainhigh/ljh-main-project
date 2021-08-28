package io.renren.modules.demo.service;

import io.renren.common.service.CrudService;
import io.renren.modules.demo.dto.ProductDTO;
import io.renren.modules.demo.entity.ProductEntity;

/**
 * 产品管理
 *
 * @author Mark
 */
public interface ProductService extends CrudService<ProductEntity, ProductDTO> {

}