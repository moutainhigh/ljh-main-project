package io.renren.modules.file.dto;

import io.renren.modules.sys.dto.SysRoleDTO;
import io.renren.modules.sys.entity.SysRoleEntity;
import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.management.relation.Role;

@Data
@ApiModel("文件角色管理")
public class FileMenuRoleDTO {
    private Long id;
    /**
     * 权限
     */
    private Integer fileMenuAuth;

    /**
     * 角色
     */
    private Long roleId;

    private SysRoleDTO sysRoleDTO;
    /**
     * 菜单
     */
    private Long menuId;

    private FilemenuDTO filemenuDTO;
}
