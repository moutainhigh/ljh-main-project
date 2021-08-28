/**
 * Copyright (c) 2018 人人开源 All rights reserved.
 *
 * www.test.com
 *
 *
 */package io.renren.datasource.annotation;

import java.lang.annotation.*;

/**
 * 多数据源注解
 *
 * @author Mark
 */
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
public @interface DataSource {
    String value() default "";
}
