package io.renren.modules.file.dao;

import io.renren.common.dao.BaseDao;
import io.renren.modules.file.entity.FileinfoEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
* 文件
*
* @author Mark
* @since 3.0 2020-12-02
*/
@Mapper
public interface FileinfoDao extends BaseDao<FileinfoEntity> {

    List<FileinfoEntity> getFineInfoByIds(String ids);
}