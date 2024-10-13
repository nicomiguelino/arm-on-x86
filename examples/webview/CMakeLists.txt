cmake_minimum_required(VERSION 3.16)
project(webview LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

set(TARGET_ARCHITECTURE arm-linux-gnueabihf)

find_package(Qt6 REQUIRED COMPONENTS Core Gui WebEngineWidgets)

set(INCLUDE_FILES
    src/mainwindow.h
)

set(SOURCE_FILES
    src/mainwindow.cpp
)

qt_add_executable(webview
    src/main.cpp
    ${INCLUDE_FILES}
    ${SOURCE_FILES}
)

target_link_libraries(webview PUBLIC
    Qt::Core
    Qt::Gui
    Qt::WebEngineWidgets
)
