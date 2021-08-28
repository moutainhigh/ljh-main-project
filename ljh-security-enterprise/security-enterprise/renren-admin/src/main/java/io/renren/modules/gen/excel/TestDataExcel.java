package io.renren.modules.gen.excel;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import lombok.Data;
import java.util.Date;

/**
 * 测试功能
 *
 * @author Mark
 * @since 3.0 2020-12-01
 */
@Data
@ContentRowHeight(20)
@HeadRowHeight(20)
@ColumnWidth(25)
public class TestDataExcel {
    @ExcelProperty(value = "用户名", index = 0)
    private String username;
    @ExcelProperty(value = "姓名", index = 1)
    private String realName;
    @ExcelProperty(value = "性别", index = 2)
    private Integer gender;
    @ExcelProperty(value = "邮箱", index = 3)
    private String email;
    @ExcelProperty(value = "类型", index = 4)
    private Integer noticeType;
    @ExcelProperty(value = "创建时间", index = 5)
    private Date createDate;
}