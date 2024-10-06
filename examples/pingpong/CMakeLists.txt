cmake_minimum_required(VERSION 3.5)

project(DBusExample1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Core DBus REQUIRED)

qt_standard_project_setup()

set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -Wl,-rpath-link, ${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE} -L${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -Wl,-rpath-link,${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE} -L${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE}")

qt_add_executable(ping include/ping-common.h src/ping.cpp)
qt_add_executable(pong include/ping-common.h src/pong.cpp)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

target_link_libraries(
    ping PRIVATE
    Qt6::Core
    Qt6::DBus
)

target_link_libraries(
    pong PRIVATE
    Qt6::Core
    Qt6::DBus
)
