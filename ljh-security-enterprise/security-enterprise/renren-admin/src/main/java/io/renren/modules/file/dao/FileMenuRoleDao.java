package io.renren.modules.file.dao;

import io.renren.common.dao.BaseDao;
import io.renren.modules.file.entity.FileMenuRole;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FileMenuRoleDao extends BaseDao<FileMenuRole> {

    List<FileMenuRole> getFineMenuRoleByRoleIds(Long[] roleIds);
}
