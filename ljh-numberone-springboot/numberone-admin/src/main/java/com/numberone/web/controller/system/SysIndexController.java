package com.numberone.web.controller.system;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import com.numberone.common.config.Global;
import com.numberone.system.domain.SysMenu;
import com.numberone.system.domain.SysUser;
import com.numberone.system.service.ISysMenuService;
import com.numberone.framework.web.base.BaseController;

/**
 * 首页 业务处理
 * 
 * @author numberone
 */
@Controller
public class SysIndexController extends BaseController
{
    Logger log = LoggerFactory.getLogger(SysIndexController.class);

    @Autowired
    private ISysMenuService menuService;

    // 系统首页
    @GetMapping("/index")
    public String index(ModelMap mmap)
    {
        log.info("====right========Call index page===========");
        log.info("=====正确=======调用系统首页===========");

        log.error("====error========Call index page===========");
        log.error("=====错误=======调用系统首页===========");

        // 取身份信息
        SysUser user = getSysUser();
        // 根据用户id取出菜单
        List<SysMenu> menus = menuService.selectMenusByUser(user);
        mmap.put("menus", menus);
        mmap.put("user", user);
        mmap.put("copyrightYear", Global.getCopyrightYear());
        return "index";
    }

    // 系统介绍
    @GetMapping("/system/main")
    public String main(ModelMap mmap)
    {
        mmap.put("version", Global.getVersion());
        return "main";
    }
}
