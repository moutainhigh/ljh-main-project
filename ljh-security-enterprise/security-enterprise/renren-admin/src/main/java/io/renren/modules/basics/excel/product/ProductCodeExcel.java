package io.renren.modules.basics.excel.product;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import lombok.Data;
import java.util.Date;

/**
 * 产品编码
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@ContentRowHeight(20)
@HeadRowHeight(20)
@ColumnWidth(25)
public class ProductCodeExcel {
    @ExcelProperty(value = "编码", index = 0)
    private String code;
    @ExcelProperty(value = "产品名称", index = 1)
    private String productName;
    @ExcelProperty(value = "产品图号", index = 2)
    private String drawingNum;
    @ExcelProperty(value = "图号版本", index = 3)
    private String drawingRev;
    @ExcelProperty(value = "材质名称", index = 4)
    private String materialName;
    @ExcelProperty(value = "物料号", index = 5)
    private String materialCodeNum;
    @ExcelProperty(value = "备注", index = 6)
    private String remark;
    @ExcelProperty(value = "附件", index = 7)
    private String attachment;
    @ExcelProperty(value = "创建人", index = 8)
    private Long creator;
    @ExcelProperty(value = "创建时间", index = 9)
    private Date createDate;
    @ExcelProperty(value = "状态", index = 10)
    private String state;
}