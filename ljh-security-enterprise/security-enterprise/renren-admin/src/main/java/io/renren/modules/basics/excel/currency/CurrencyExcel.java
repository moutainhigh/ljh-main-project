package io.renren.modules.basics.excel.currency;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentRowHeight;
import com.alibaba.excel.annotation.write.style.HeadRowHeight;
import lombok.Data;

/**
 * 币种
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@ContentRowHeight(20)
@HeadRowHeight(20)
@ColumnWidth(25)
public class CurrencyExcel {
    @ExcelProperty(value = "中文名", index = 0)
    private String chnName;
    @ExcelProperty(value = "英文名", index = 1)
    private String enName;
}