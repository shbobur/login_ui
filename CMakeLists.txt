cmake_minimum_required(VERSION 3.16)
project(login-portfolio VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick QuickControls2)

set(PROJECT_SOURCES
    src/main.cpp
)

qt_add_executable(${PROJECT_NAME}
    src/main.cpp
    resources.qrc
)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    Qt6::Quick
    Qt6::QuickControls2
)
