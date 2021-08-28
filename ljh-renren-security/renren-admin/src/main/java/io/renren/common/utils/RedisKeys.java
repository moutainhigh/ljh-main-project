package io.renren.common.utils;

/**
 * Redis所有Keys
 *
 * @author Mark
 */
public class RedisKeys {

    public static String getSysConfigKey(String key){
        return "sys:config:" + key;
    }

    public static String getShiroSessionKey(String key){
        return "sessionid:" + key;
    }
}
