package io.renren.modules.file.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.utils.ConvertUtils;
import io.renren.modules.file.dao.FileMenuRoleDao;
import io.renren.modules.file.dto.FileMenuRoleDTO;
import io.renren.modules.file.dto.FilemenuDTO;
import io.renren.modules.file.entity.FileMenuRole;
import io.renren.modules.file.entity.FilemenuEntity;
import io.renren.modules.file.service.FileMenuRoleService;
import io.renren.modules.file.service.FilemenuService;
import io.renren.modules.security.user.SecurityUser;
import io.renren.modules.sys.dto.SysRoleDTO;
import io.renren.modules.sys.dto.SysUserDTO;
import io.renren.modules.sys.service.SysRoleService;
import io.renren.modules.sys.service.SysRoleUserService;
import io.renren.modules.sys.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FileMenuRoleServiceImpl extends CrudServiceImpl<FileMenuRoleDao,FileMenuRole, FileMenuRoleDTO> implements FileMenuRoleService {

    @Autowired
    private SysRoleService sysRoleService;
    @Autowired
    private FilemenuService filemenuService;
    @Autowired
    private SysRoleUserService sysRoleUserService;

    @Override
    public QueryWrapper<FileMenuRole> getWrapper(Map<String, Object> params){
        QueryWrapper<FileMenuRole> wrapper = new QueryWrapper<>();

        return wrapper;
    }

    @Override
    @Transactional
    public void saveFileMenuRole(List<FilemenuDTO> fileMenuRoles,Long roleId) {
        QueryWrapper<FileMenuRole> wrapper = new QueryWrapper<>();
        wrapper.eq("role_id",roleId);
        baseDao.delete(wrapper);
        saveFileMenuRoleChildren(fileMenuRoles,roleId);
    }

    private void saveFileMenuRoleChildren(List<FilemenuDTO> fileMenuRoles,Long roleId){
        for (FilemenuDTO filemenuDTO:fileMenuRoles) {
            if(filemenuDTO.getFileMenuAuth().equals(0)){
                continue;
            }
            FileMenuRole fileMenuRole = new FileMenuRole();
            this.saveFileMenuRoleChildren(filemenuDTO.getChildren(),roleId);
            fileMenuRole.setFileMenuAuth(filemenuDTO.getFileMenuAuth());
            fileMenuRole.setMenuId(filemenuDTO.getId());
            fileMenuRole.setRoleId(roleId);
            baseDao.insert(fileMenuRole);
        }
    }

    @Override
    public List<FileMenuRole> fileMenuRoleListByRoleId(Long roleId) {
        QueryWrapper<FileMenuRole> wrapper = new QueryWrapper<>();
        wrapper.eq("role_id",roleId);
        List<FileMenuRole> fileMenuRoles = baseDao.selectList(wrapper);
        return fileMenuRoles;
    }

    @Override
    public List<FileMenuRoleDTO> fileMenuRoleList() {
        QueryWrapper<FileMenuRole> wrapper = new QueryWrapper<>();
        List<FileMenuRole> fileMenuRoles = baseDao.selectList(wrapper);
        List<FileMenuRoleDTO> fileMenuRoleDTOS = ConvertUtils.sourceToTarget(fileMenuRoles,FileMenuRoleDTO.class);
        for (FileMenuRoleDTO fileMenuRoleDTO:fileMenuRoleDTOS) {
            fileMenuRoleDTO.setSysRoleDTO(sysRoleService.get(fileMenuRoleDTO.getRoleId()));
            fileMenuRoleDTO.setFilemenuDTO(filemenuService.get(fileMenuRoleDTO.getMenuId()));
        }
        return fileMenuRoleDTOS;
    }

    @Override
    public List<FileMenuRole> getUserFileMenuRole() {
        List<Long> roleIdList = sysRoleUserService.getRoleIdList(SecurityUser.getUserId());
        Long[] roleIds = roleIdList.toArray(new Long[roleIdList.size()]);
        return baseDao.getFineMenuRoleByRoleIds(roleIds);
    }
}
