cmake_minimum_required(VERSION 3.0.0)
project(filter_1st_order_test VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_CXX_FLAGS "-fdiagnostics-color=always -fno-rtti -fno-exceptions -fno-non-call-exceptions -fno-use-cxa-atexit -fno-common")
set(CMAKE_CXX_FLAGS_DEBUG_INIT "-g -Os -Wall -Wextra -Wpedantic")
set(CMAKE_CXX_FLAGS_RELEASE_INIT "-O2")

add_executable(filter_1st_order_test filter_1st_order_test.cpp filter_1st_order.cpp matrix_io.cpp)
