package com.example.mylsposedmodule;

import android.os.Build;
import de.robv.android.xposed.XC_MethodHook;
import de.robv.android.xposed.XposedBridge;
import de.robv.android.xposed.XposedHelpers;
import de.robv.android.xposed.callbacks.XC_LoadPackage;

public class MyHook {

    public static void hook(XC_LoadPackage.LoadPackageParam lpparam) {
        try {
            // Hook method "get" của SystemProperties
            XposedHelpers.findAndHookMethod(
                "android.os.SystemProperties", // Lớp cần hook
                lpparam.classLoader,
                "get", // Tên phương thức
                String.class, // Tham số đầu vào là tên prop
                String.class, // Tham số đầu vào là giá trị mặc định
                new XC_MethodHook() {
                    @Override
                    protected void beforeHookedMethod(MethodHookParam param) throws Throwable {
                        String propName = (String) param.args[0]; // Lấy tên prop
                        if ("ro.product.model".equals(propName)) {
                            // Thay đổi thông tin model
                            param.setResult("Fake Model Name");
                        }
                    }
                }
            );

        } catch (Throwable t) {
            XposedBridge.log("Error in MyHook: " + t.getMessage());
        }
    }
}