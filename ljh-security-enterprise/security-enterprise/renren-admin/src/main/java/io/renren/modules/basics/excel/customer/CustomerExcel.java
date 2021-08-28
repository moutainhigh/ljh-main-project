package io.renren.modules.basics.excel.customer;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import lombok.Data;
import java.util.Date;

/**
 * 客户信息
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@ContentRowHeight(20)
@HeadRowHeight(20)
@ColumnWidth(25)
public class CustomerExcel {
    @ExcelProperty(value = "名称", index = 0)
    private String customerName;
    @ExcelProperty(value = "简称", index = 1)
    private String nameAbb;
    @ExcelProperty(value = "国别", index = 2)
    private String country;
    @ExcelProperty(value = "地址", index = 3)
    private String address;
    @ExcelProperty(value = "联系人", index = 4)
    private String contactPerson;
    @ExcelProperty(value = "附件", index = 5)
    private String attachment;
    @ExcelProperty(value = "备注", index = 6)
    private String remark;
    @ExcelProperty(value = "状态", index = 7)
    private String state;
    @ExcelProperty(value = "创建人", index = 8)
    private Long creator;
    @ExcelProperty(value = "创建时间", index = 9)
    private Date createDate;
}