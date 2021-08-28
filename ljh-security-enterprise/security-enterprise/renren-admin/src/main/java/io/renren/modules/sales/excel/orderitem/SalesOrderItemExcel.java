package io.renren.modules.sales.excel.orderitem;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import lombok.Data;
import java.util.Date;

/**
 * 订单字表
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@ContentRowHeight(20)
@HeadRowHeight(20)
@ColumnWidth(25)
public class SalesOrderItemExcel {
    @ExcelProperty(value = "销售订单id", index = 0)
    private Long salesOrderId;
    @ExcelProperty(value = "行号", index = 1)
    private Integer lineNum;
    @ExcelProperty(value = "产品编码", index = 2)
    private String productCode;
    @ExcelProperty(value = "数量", index = 3)
    private Integer qty;
    @ExcelProperty(value = "需求日期", index = 4)
    private Date needDate;
    @ExcelProperty(value = "计划完成日期", index = 5)
    private Date planFinishDate;
    @ExcelProperty(value = "备注", index = 6)
    private String remark;
    @ExcelProperty(value = "创建人", index = 7)
    private Long creator;
    @ExcelProperty(value = "创建时间", index = 8)
    private Date createDate;
}