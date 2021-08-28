package io.renren.modules.file.dao;

import io.renren.common.dao.BaseDao;
import io.renren.modules.file.entity.FilemenuEntity;
import org.apache.ibatis.annotations.Mapper;

/**
* 文件管理
*
* @author Mark
* @since 3.0 2020-12-01
*/
@Mapper
public interface FilemenuDao extends BaseDao<FilemenuEntity> {
	
}