package io.renren.modules.file.service;

import io.renren.common.service.CrudService;
import io.renren.modules.file.dto.FileinfoDTO;
import io.renren.modules.file.entity.FileinfoEntity;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.zip.ZipOutputStream;

/**
 * 文件
 *
 * @author Mark
 * @since 3.0 2020-12-02
 */
public interface FileinfoService extends CrudService<FileinfoEntity, FileinfoDTO> {

    List<FileinfoDTO> getList(Long parentId);

    List<FileinfoDTO> getListByIds(String ids);

    void downloadAllFile(HttpServletResponse response, String ids,String menuName);
}