package com.example.mylsposedmodule;

import de.robv.android.xposed.IXposedHookLoadPackage;
import de.robv.android.xposed.callbacks.XC_LoadPackage;

public class MainHook implements IXposedHookLoadPackage {

    @Override
    public void handleLoadPackage(final XC_LoadPackage.LoadPackageParam lpparam) throws Throwable {
        // Chỉ hook một ứng dụng cụ thể, ví dụ: com.target.app
        if (!lpparam.packageName.equals("com.target.app")) {
            return;
        }

        // Gọi lớp hook chi tiết
        MyHook.hook(lpparam);
    }
}