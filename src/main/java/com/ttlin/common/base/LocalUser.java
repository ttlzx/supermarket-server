package com.ttlin.common.base;

import com.ttlin.pojo.entity.User;

import java.util.HashMap;
import java.util.Map;

public class LocalUser {

    private static ThreadLocal<Map<String, Object>> threadLocal = new ThreadLocal<>();

    public static void set(User user, Integer scope) {
        Map<String, Object> map = new HashMap<>();
        map.put("user", user);
        map.put("scope", scope);
        LocalUser.threadLocal.set(map);
    }

    public static User getUser() {
        Map<String, Object> map = LocalUser.threadLocal.get();
        User user = (User) map.get("user");
        return user;
    }

    public static Integer getScope() {
        Map<String, Object> map = LocalUser.threadLocal.get();
        Integer scope = (Integer) map.get("scope");
        return scope;
    }

    public static void clear() {
        LocalUser.threadLocal.remove();
    }
}
