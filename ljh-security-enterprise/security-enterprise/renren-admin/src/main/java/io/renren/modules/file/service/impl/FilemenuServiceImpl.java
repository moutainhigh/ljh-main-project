package io.renren.modules.file.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.utils.ConvertUtils;
import io.renren.modules.file.dao.FilemenuDao;
import io.renren.modules.file.dto.FilemenuDTO;
import io.renren.modules.file.entity.FileMenuRole;
import io.renren.modules.file.entity.FilemenuEntity;
import io.renren.modules.file.service.FileMenuRoleService;
import io.renren.modules.file.service.FilemenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 文件管理
 *
 * @author Mark
 * @since 3.0 2020-12-01
 */
@Service
public class FilemenuServiceImpl extends CrudServiceImpl<FilemenuDao, FilemenuEntity, FilemenuDTO> implements FilemenuService {

    @Autowired
    private FileMenuRoleService fileMenuRoleService;

    @Override
    public QueryWrapper<FilemenuEntity> getWrapper(Map<String, Object> params){
        QueryWrapper<FilemenuEntity> wrapper = new QueryWrapper<>();

        return wrapper;
    }


    private List<FilemenuDTO> getChildren(Long parentId) {
        QueryWrapper<FilemenuEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("parentid",parentId);
        List<FilemenuEntity> filemenuEntities = super.baseDao.selectList(wrapper);
        return ConvertUtils.sourceToTarget(filemenuEntities,FilemenuDTO.class);
    }

    @Override
    public List<FilemenuDTO> getTreeData() {
        QueryWrapper<FilemenuEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("parentid",0);
        List<FilemenuEntity> filemenuEntities = baseDao.selectList(wrapper);
        List<FilemenuDTO> filemenuDTOS = ConvertUtils.sourceToTarget(filemenuEntities,FilemenuDTO.class);
        List<FileMenuRole> fileMenuRoleDTOS = fileMenuRoleService.getUserFileMenuRole();
        return treeMenuList(filemenuDTOS,fileMenuRoleDTOS);
    }

    @Override
    public List<FilemenuDTO> getTreeDataByRoleId(Long roleId) {
        QueryWrapper<FilemenuEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("parentid",0);
        List<FilemenuEntity> filemenuEntities = baseDao.selectList(wrapper);
        List<FilemenuDTO> filemenuDTOS = ConvertUtils.sourceToTarget(filemenuEntities,FilemenuDTO.class);
        List<FileMenuRole> fileMenuRoleDTOS = fileMenuRoleService.fileMenuRoleListByRoleId(roleId);
        return treeMenuList(filemenuDTOS,fileMenuRoleDTOS);
    }

    private List<FilemenuDTO> treeMenuList(List<FilemenuDTO> filemenuDTOS,List<FileMenuRole> fileMenuRoles){
        List<FilemenuDTO> filemenuDTOList = new ArrayList<>();
        for (FilemenuDTO filemenuDTO:filemenuDTOS) {
            for (FileMenuRole fileMenuRole:fileMenuRoles) {
                if(fileMenuRole.getMenuId().equals(filemenuDTO.getId())){
                    filemenuDTO.setFileMenuAuth(fileMenuRole.getFileMenuAuth());
                    break;
                }
            }
            filemenuDTO.setChildren(this.getChildren(filemenuDTO.getId()));
            this.treeMenuList(filemenuDTO.getChildren(),fileMenuRoles);
            filemenuDTOList.add(filemenuDTO);
        }
        return filemenuDTOList;

    }
}