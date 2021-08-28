package io.renren.modules.file.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.renren.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 文件菜单角色中间表
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("file_menu_role")
public class FileMenuRole extends BaseEntity {

    /**
     * 权限
     */
    private Integer fileMenuAuth;

    /**
     * 角色
     */
    private Long roleId;

    /**
     * 菜单
     */
    private Long menuId;
}
