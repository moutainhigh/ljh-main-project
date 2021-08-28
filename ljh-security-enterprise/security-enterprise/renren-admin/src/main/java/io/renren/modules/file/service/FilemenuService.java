package io.renren.modules.file.service;

import io.renren.common.service.CrudService;
import io.renren.modules.file.dto.FilemenuDTO;
import io.renren.modules.file.entity.FilemenuEntity;

import java.util.List;

/**
 * 文件管理
 *
 * @author Mark
 * @since 3.0 2020-12-01
 */
public interface FilemenuService extends CrudService<FilemenuEntity, FilemenuDTO> {


    /**
     * 获取菜单树数据
     * @return
     */
    List<FilemenuDTO> getTreeData();

    List<FilemenuDTO> getTreeDataByRoleId(Long roleId);
}