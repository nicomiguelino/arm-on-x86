cmake_minimum_required(VERSION 3.5)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(TARGET_ARCHITECTURE arm-linux-gnueabihf)

find_package(Qt6 REQUIRED COMPONENTS Core Gui WebEngineWidgets)

qt_add_executable(webengine2
    main.cpp
)

target_link_libraries(webengine2 PUBLIC
    Qt::Core
    Qt::Gui
    Qt::WebEngineWidgets
)
