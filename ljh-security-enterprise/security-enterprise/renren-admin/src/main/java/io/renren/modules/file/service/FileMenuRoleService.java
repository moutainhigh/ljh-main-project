package io.renren.modules.file.service;

import io.renren.common.service.CrudService;
import io.renren.modules.file.dto.FileMenuRoleDTO;
import io.renren.modules.file.dto.FilemenuDTO;
import io.renren.modules.file.entity.FileMenuRole;

import java.util.List;

public interface FileMenuRoleService extends CrudService<FileMenuRole, FileMenuRoleDTO> {

    void saveFileMenuRole(List<FilemenuDTO> fileMenuRoles, Long roleId);

    List<FileMenuRole> fileMenuRoleListByRoleId(Long roleId);

    List<FileMenuRoleDTO> fileMenuRoleList();

    List<FileMenuRole> getUserFileMenuRole();



}
