cmake_minimum_required(VERSION 3.10)

project(zygisk-prop-app)

add_library(zygisk SHARED module.cpp)

find_library(log-lib log)

target_link_libraries(zygisk ${log-lib})
