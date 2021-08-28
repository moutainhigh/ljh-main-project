package io.renren.annotation;

import java.lang.annotation.*;

/**
 * 登录效验
 *
 * @author Mark
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Login {
}
