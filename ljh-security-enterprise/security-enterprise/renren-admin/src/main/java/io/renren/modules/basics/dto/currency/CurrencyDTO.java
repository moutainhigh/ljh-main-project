package io.renren.modules.basics.dto.currency;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
* 币种
*
* @author Mark
* @since 3.0 2020-12-14
*/
@Data
@ApiModel(value = "币种")
public class CurrencyDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    @ApiModelProperty(value = "中文名")
    private String chnName;
    @ApiModelProperty(value = "英文名")
    private String enName;

}