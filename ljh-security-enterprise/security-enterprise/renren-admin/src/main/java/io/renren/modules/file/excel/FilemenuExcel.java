package io.renren.modules.file.excel;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import lombok.Data;
import java.util.Date;

/**
 * 文件管理
 *
 * @author Mark
 * @since 3.0 2020-12-01
 */
@Data
@ContentRowHeight(20)
@HeadRowHeight(20)
@ColumnWidth(25)
public class FilemenuExcel {
    @ExcelProperty(value = "id", index = 0)
    private Long id;
    @ExcelProperty(value = "目录文件名称", index = 1)
    private String name;
    @ExcelProperty(value = "父id", index = 2)
    private Long parentid;
    @ExcelProperty(value = "创建人", index = 3)
    private Long creator;
    @ExcelProperty(value = "创建时间", index = 4)
    private Date createDate;
}