package io.renren.modules.basics.entity.currency;

import lombok.Data;
import lombok.EqualsAndHashCode;
import com.baomidou.mybatisplus.annotation.*;

/**
 * 币种
 *
 * @author Mark
 * @since 3.0 2020-12-14
 */
@Data
@EqualsAndHashCode(callSuper=false)
@TableName("currency")
public class CurrencyEntity {
	private static final long serialVersionUID = 1L;

	@TableId
	private Long id;
	/**
	* 中文名
	*/
	private String chnName;
	/**
	* 英文名
	*/
	private String enName;
}