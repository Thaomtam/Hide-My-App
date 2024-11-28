cmake_minimum_required(VERSION 3.10)

project(zygisk_module)

# Thêm Android NDK
set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_SYSTEM_VERSION 21)
set(CMAKE_ANDROID_ARCH_ABI arm64-v8a)

# Thêm tệp nguồn
add_library(zygisk SHARED module.cpp)

# Link thư viện cần thiết
target_link_libraries(zygisk log)
