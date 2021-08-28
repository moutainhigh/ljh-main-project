package io.renren.modules.file.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import io.renren.common.service.impl.CrudServiceImpl;
import io.renren.common.utils.ConvertUtils;
import io.renren.modules.file.dao.FileinfoDao;
import io.renren.modules.file.dto.FileinfoDTO;
import io.renren.modules.file.entity.FileinfoEntity;
import io.renren.modules.file.service.FileinfoService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * 文件
 *
 * @author Mark
 * @since 3.0 2020-12-02
 */
@Service
public class FileinfoServiceImpl extends CrudServiceImpl<FileinfoDao, FileinfoEntity, FileinfoDTO> implements FileinfoService {

    private static final String filePath="F:"+File.separator+"upload"+File.separator;

    @Override
    public QueryWrapper<FileinfoEntity> getWrapper(Map<String, Object> params){
        QueryWrapper<FileinfoEntity> wrapper = new QueryWrapper<>();

        String filename = (String)params.get("filename");
        wrapper.like(StringUtils.isNotBlank(filename), "fileName", filename);
        String effective = (String)params.get("effective");
        wrapper.eq(StringUtils.isNotBlank(effective), "effective", effective);
        String format = (String)params.get("format");
        wrapper.eq(StringUtils.isNotBlank(format), "format", format);
        String filenum = (String)params.get("filenum");
        wrapper.eq(StringUtils.isNotBlank(filenum), "fileNum", filenum);
        String stdstate = (String)params.get("stdstate");
        wrapper.eq(StringUtils.isNotBlank(stdstate), "stdState", stdstate);
        String menuid = (String) params.get("menuid");
        wrapper.eq(StringUtils.isNotBlank(menuid),"menuid",menuid);
        return wrapper;
    }


    @Override
    public List<FileinfoDTO> getList(Long parentId) {
        QueryWrapper<FileinfoEntity> wrapper = new QueryWrapper<>();
        wrapper.eq("menuid",parentId);
        List<FileinfoEntity> fileinfoEntities = baseDao.selectList(wrapper);
        return ConvertUtils.sourceToTarget(fileinfoEntities,FileinfoDTO.class);
    }

    @Override
    public List<FileinfoDTO> getListByIds(String ids) {
        List<FileinfoEntity> fileinfoEntities = baseDao.getFineInfoByIds(ids);
        return ConvertUtils.sourceToTarget(fileinfoEntities,FileinfoDTO.class);
    }

    public void downloadAllFile(HttpServletResponse response, String ids,String menuName) {
        String downloadName = UUID.randomUUID()+".zip";
        try {
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition", "attachment;fileName=" + URLEncoder.encode(downloadName, "UTF-8"));
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("下载文件名编码时出现错误.", e);
        }

        OutputStream outputStream = null;
        ZipOutputStream zos = null;
        try {
            outputStream = response.getOutputStream();
            zos = new ZipOutputStream(outputStream);
            // 将文件流写入zip中
            downloadTolocal(zos,ids,menuName);

        } catch (IOException e) {
            throw new RuntimeException("文件下载失败！");
        }finally {
            if(zos != null) {
                try {
                    zos.close();
                } catch (Exception e2) {
                    throw new RuntimeException("关闭输入流时出现错误！");
                }
            }
            if(outputStream != null) {
                try {
                    outputStream.close();
                } catch (Exception e2) {
                    throw new RuntimeException("关闭输入流时出现错误！");
                }
            }

        }

    }

    private void downloadTolocal(ZipOutputStream zos,String ids,String menuName) {
        List<FileinfoDTO> fileinfoDTOS = getListByIds(ids);
        for (FileinfoDTO fileinfoDTO : fileinfoDTOS) {
            File file=new File(filePath+ menuName + File.separator +fileinfoDTO.getFilename());
            //文件名称（带后缀）
            String fileName = fileinfoDTO.getFilename();
            InputStream is = null;
            BufferedInputStream in = null;
            byte[] buffer = new byte[1024];
            int len;
            //创建zip实体（一个文件对应一个ZipEntry）
            ZipEntry entry = new ZipEntry(fileName);
            try {
                //获取需要下载的文件流
                is = new FileInputStream(file);
                in = new BufferedInputStream(is);
                zos.putNextEntry(entry);
                //文件流循环写入ZipOutputStream
                while ((len = in.read(buffer)) != -1 ) {
                    zos.write(buffer, 0, len);
                }
            } catch (Exception e) {
                throw new RuntimeException("下载全部附件--压缩文件出错1！");
            }finally {
                if(entry != null) {
                    try {
                        zos.closeEntry();
                    } catch (Exception e2) {
                        throw new RuntimeException("下载全部附件--zip实体关闭失败！");
                    }
                }
                if(in != null) {
                    try {
                        in.close();
                    } catch (Exception e2) {
                        throw new RuntimeException("下载全部附件--文件输入流关闭失败！");
                    }
                }
                if(is != null) {
                    try {
                        is.close();
                    }catch (Exception e) {
                        throw new RuntimeException("下载全部附件--输入缓冲流关闭失败！");
                    }
                }


            }

        }
    }
}