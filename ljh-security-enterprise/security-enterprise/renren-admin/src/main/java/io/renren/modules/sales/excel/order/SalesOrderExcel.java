package io.renren.modules.sales.excel.order;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import lombok.Data;
import java.util.Date;

/**
 * 销售订单
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@ContentRowHeight(20)
@HeadRowHeight(20)
@ColumnWidth(25)
public class SalesOrderExcel {
    @ExcelProperty(value = "销售订单号", index = 0)
    private String salesOrderNum;
    @ExcelProperty(value = "客户订单号", index = 1)
    private String customerPurchaseNum;
    @ExcelProperty(value = "客户", index = 2)
    private Long customerId;
    @ExcelProperty(value = "币种", index = 3)
    private Long currencyId;
    @ExcelProperty(value = "备注", index = 4)
    private String remark;
    @ExcelProperty(value = "状态", index = 5)
    private String state;
    @ExcelProperty(value = "创建人", index = 6)
    private Long creator;
    @ExcelProperty(value = "创建时间", index = 7)
    private Date createDate;
    @ExcelProperty(value = "修改人", index = 8)
    private Long updater;
    @ExcelProperty(value = "修改时间", index = 9)
    private Date updateDate;
}