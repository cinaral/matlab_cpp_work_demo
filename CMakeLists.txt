cmake_minimum_required(VERSION 3.0.0)
project(filter_1st_order_test VERSION 1.0.0)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(filter_1st_order_test filter_1st_order_test.cpp filter_1st_order.cpp matrix_io.cpp)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
