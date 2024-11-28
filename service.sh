#!/system/bin/sh

# Kiểm tra xem module Zygisk có hoạt động không
if [ ! -f "/data/adb/zygisk" ]; then
    exit 1
fi
