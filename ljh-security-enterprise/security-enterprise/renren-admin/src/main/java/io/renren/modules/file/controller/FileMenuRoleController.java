package io.renren.modules.file.controller;

import com.alibaba.fastjson.JSON;
import io.renren.common.annotation.LogOperation;
import io.renren.common.utils.Result;
import io.renren.common.validator.ValidatorUtils;
import io.renren.modules.file.dto.FileMenuRoleDTO;
import io.renren.modules.file.dto.FilemenuDTO;
import io.renren.modules.file.entity.FileMenuRole;
import io.renren.modules.file.service.FileMenuRoleService;
import io.renren.modules.sys.service.SysRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("file/filemenurole")
@Api(tags="文件角色管理")
public class FileMenuRoleController {

    @Autowired
    private FileMenuRoleService fileMenuRoleService;

    @GetMapping("fileMenuRoleList")
    @ApiOperation("文件角色管理")
    public Result<List<FileMenuRoleDTO>> fileMenuRoleList(){
        List<FileMenuRoleDTO> fileMenuRoleDTOS = fileMenuRoleService.fileMenuRoleList();
        return new Result<List<FileMenuRoleDTO>>().ok(fileMenuRoleDTOS);
    }

    @PostMapping("/save")
    @ApiOperation("保存")
    @LogOperation("保存")
    @ResponseBody
    public Result save(String requestData, Long roleId){
        List<FilemenuDTO> filemenuDTOS = JSON.parseArray(requestData,FilemenuDTO.class);
        fileMenuRoleService.saveFileMenuRole(filemenuDTOS,roleId);
        return new Result();
    }
}
