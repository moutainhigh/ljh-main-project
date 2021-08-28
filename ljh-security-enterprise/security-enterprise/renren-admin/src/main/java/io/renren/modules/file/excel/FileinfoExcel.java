package io.renren.modules.file.excel;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import lombok.Data;
import java.util.Date;

/**
 * 文件
 *
 * @author Mark
 * @since 3.0 2020-12-02
 */
@Data
@ContentRowHeight(20)
@HeadRowHeight(20)
@ColumnWidth(25)
public class FileinfoExcel {
    @ExcelProperty(value = "文件id", index = 0)
    private Integer fileid;
    @ExcelProperty(value = "文件名称", index = 1)
    private String filename;
    @ExcelProperty(value = "备注", index = 2)
    private String remark;
    @ExcelProperty(value = "版本", index = 3)
    private String revision;
    @ExcelProperty(value = "是否有效", index = 4)
    private Integer effective;
    @ExcelProperty(value = "文件格式", index = 5)
    private String format;
    @ExcelProperty(value = "文件大小", index = 6)
    private Integer size;
    @ExcelProperty(value = "文件编号", index = 7)
    private String filenum;
    @ExcelProperty(value = "管理备注", index = 8)
    private String mgtremark;
    @ExcelProperty(value = "标准状态", index = 9)
    private String stdstate;
    @ExcelProperty(value = "修改人", index = 10)
    private Date updater;
    @ExcelProperty(value = "修改时间", index = 11)
    private Date updatedate;
    @ExcelProperty(value = "创建人", index = 12)
    private String creator;
    @ExcelProperty(value = "创建时间", index = 13)
    private Date createdate;
}