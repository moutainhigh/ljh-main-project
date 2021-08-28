package io.renren.modules.file.controller;

import io.renren.common.annotation.LogOperation;
import io.renren.common.constant.Constant;
import io.renren.common.exception.ErrorCode;
import io.renren.common.page.PageData;
import io.renren.common.utils.ExcelUtils;
import io.renren.common.utils.Result;
import io.renren.common.validator.AssertUtils;
import io.renren.common.validator.ValidatorUtils;
import io.renren.common.validator.group.AddGroup;
import io.renren.common.validator.group.DefaultGroup;
import io.renren.common.validator.group.UpdateGroup;
import io.renren.modules.file.dto.FileinfoDTO;
import io.renren.modules.file.dto.FilemenuDTO;
import io.renren.modules.file.excel.FileinfoExcel;
import io.renren.modules.file.service.FileinfoService;
import io.renren.modules.file.service.FilemenuService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


/**
* 文件
*
* @author Mark
* @since 3.0 2020-12-02
*/
@RestController
@RequestMapping("file/fileinfo")
@Api(tags="文件")
public class FileinfoController {
    @Autowired
    private FileinfoService fileinfoService;
    @Autowired
    private FilemenuService filemenuService;

    private static final String filePath="F:"+File.separator+"upload"+File.separator;;

    @GetMapping("page")
    @ApiOperation("分页")
    @ApiImplicitParams({
        @ApiImplicitParam(name = Constant.PAGE, value = "当前页码，从1开始", paramType = "query", required = true, dataType="int") ,
        @ApiImplicitParam(name = Constant.LIMIT, value = "每页显示记录数", paramType = "query",required = true, dataType="int") ,
        @ApiImplicitParam(name = Constant.ORDER_FIELD, value = "排序字段", paramType = "query", dataType="String") ,
        @ApiImplicitParam(name = Constant.ORDER, value = "排序方式，可选值(asc、desc)", paramType = "query", dataType="String")
    })
    public Result<PageData<FileinfoDTO>> page(@ApiIgnore @RequestParam Map<String, Object> params){
        PageData<FileinfoDTO> page = fileinfoService.page(params);

        return new Result<PageData<FileinfoDTO>>().ok(page);
    }

    @GetMapping("{id}")
    @ApiOperation("信息")
    public Result<FileinfoDTO> get(@PathVariable("id") Long id){
        FileinfoDTO data = fileinfoService.get(id);

        return new Result<FileinfoDTO>().ok(data);
    }

    @GetMapping("downloadfile")
    @ApiOperation("文件下载")
    public void downloadfile(HttpServletResponse response, String ids,String menuName){
        Pattern pattern = Pattern.compile("[\\s\\\\/:\\*\\?\\\"<>\\|]");
        Matcher matcher = pattern.matcher(menuName);
        menuName= matcher.replaceAll("");
        fileinfoService.downloadAllFile(response,ids.substring(0,ids.length()-1),menuName);
//        File root = new File("E:\\upload");
//        File[] listFiles = root.listFiles();
//        List<FilemenuDTO> filemenuDTOs = filemenuService.list(null);
//        for (FilemenuDTO filemenuDTO:filemenuDTOs) {
//            for (File file : listFiles) {
//                String name = file.getName().substring(file.getName().lastIndexOf("\\") + 1);
//                if(name.equals(filemenuDTO.getId().toString())){
//                    String mName = filemenuDTO.getName();
//                    Pattern pattern = Pattern.compile("[\\s\\\\/:\\*\\?\\\"<>\\|]");
//                    Matcher matcher = pattern.matcher(mName);
//                    mName= matcher.replaceAll("");
//                    file.renameTo(new File("E:\\upload\\"+mName+filemenuDTO.getId()));
//                }
//            }
//        }
    }

    @RequestMapping(value = "/getPDFByFileId")
    public void getPDFByFileId(Long id,String menuName,HttpServletResponse response) throws IOException {
        FileinfoDTO fileinfoDTO = fileinfoService.get(id);
        Pattern pattern = Pattern.compile("[\\s\\\\/:\\*\\?\\\"<>\\|]");
        Matcher matcher = pattern.matcher(menuName);
        menuName= matcher.replaceAll("");
        String path = filePath+menuName+"\\"+fileinfoDTO.getFilename();
        InputStream in = new FileInputStream(path);
        OutputStream out = null;
        byte[] buf = new byte[1024];
        int legth = 0;
        try {
            out = response.getOutputStream();
            while ((legth = in.read(buf)) != -1) {
                out.write(buf, 0, legth);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.close();
            }
        }
    }

    @PostMapping("uploadfile")
    @ApiOperation("文件上传")
    public Result<FileinfoDTO> fileUdpload(@RequestParam("file") MultipartFile file,String menuName){
        if (file.isEmpty()) {
            return new Result().error(ErrorCode.UPLOAD_FILE_EMPTY);
        }
        Pattern pattern = Pattern.compile("[\\s\\\\/:\\*\\?\\\"<>\\|]");
        Matcher matcher = pattern.matcher(menuName);
        menuName= matcher.replaceAll("");
        File dest = new File(filePath+menuName+"\\" +file.getOriginalFilename());
        if(!dest.exists()){
            dest.mkdirs();
        }
        try {
            file.transferTo(dest);
        } catch (IOException e) {
            e.printStackTrace();
        }
        FileinfoDTO fileinfoEntity = new FileinfoDTO();
        String[] str = file.getOriginalFilename().split("\\.");
        fileinfoEntity.setFilename(file.getOriginalFilename());
        fileinfoEntity.setFormat(str[1]);
        fileinfoEntity.setSize((int) file.getSize());
        fileinfoEntity.setEffective(1);
        fileinfoEntity.setStdstate("有效");
        return new Result<FileinfoDTO>().ok(fileinfoEntity);
    }

    @PostMapping
    @ApiOperation("保存")
    @LogOperation("保存")
    public Result save(@RequestBody FileinfoDTO dto){
        //效验数据
        ValidatorUtils.validateEntity(dto, AddGroup.class, DefaultGroup.class);

        fileinfoService.save(dto);

        return new Result();
    }

    @PutMapping
    @ApiOperation("修改")
    @LogOperation("修改")
    public Result update(@RequestBody FileinfoDTO dto){
        //效验数据
        ValidatorUtils.validateEntity(dto, UpdateGroup.class, DefaultGroup.class);

        fileinfoService.update(dto);

        return new Result();
    }

    @DeleteMapping
    @ApiOperation("删除")
    @LogOperation("删除")
    public Result delete(@RequestBody Long[] ids){
        //效验数据
        AssertUtils.isArrayEmpty(ids, "id");

        fileinfoService.delete(ids);

        return new Result();
    }

    @GetMapping("export")
    @ApiOperation("导出")
    @LogOperation("导出")
    public void export(@ApiIgnore @RequestParam Map<String, Object> params, HttpServletResponse response) throws Exception {
        List<FileinfoDTO> list = fileinfoService.list(params);

        ExcelUtils.exportExcelToTarget(response, null, "文件", list, FileinfoExcel.class);
    }

}