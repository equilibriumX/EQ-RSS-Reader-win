cmake_minimum_required(VERSION 3.24)
project(EQ-RSS-Reader VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.8 REQUIRED COMPONENTS Core Gui Widgets Qml Quick QuickControls2 Svg WebEngineQuick)
qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(EQ-RSS-Reader WIN32
    src/main.cpp
    src/AppSettings.cpp
    src/AppSettings.h
    src/TrayController.cpp
    src/TrayController.h
)

target_link_libraries(EQ-RSS-Reader PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Widgets
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Svg
    Qt6::WebEngineQuick
)


set_source_files_properties(
    qml/Main.qml PROPERTIES QT_RESOURCE_ALIAS Main.qml
)
set_source_files_properties(
    qml/HeaderBar.qml PROPERTIES QT_RESOURCE_ALIAS HeaderBar.qml
)
set_source_files_properties(
    qml/ReaderWorkspace.qml PROPERTIES QT_RESOURCE_ALIAS ReaderWorkspace.qml
)
set_source_files_properties(
    qml/ArticleRenderer.qml PROPERTIES QT_RESOURCE_ALIAS ArticleRenderer.qml
)
set_source_files_properties(
    qml/FeedSidebar.qml PROPERTIES QT_RESOURCE_ALIAS FeedSidebar.qml
)
set_source_files_properties(
    qml/ManagementSidebar.qml PROPERTIES QT_RESOURCE_ALIAS ManagementSidebar.qml
)
set_source_files_properties(
    qml/AppIcon.qml PROPERTIES QT_RESOURCE_ALIAS AppIcon.qml
)
set_source_files_properties(
    qml/AppStyle.qml PROPERTIES QT_RESOURCE_ALIAS AppStyle.qml
)
set_source_files_properties(
    qml/SettingsDialog.qml PROPERTIES QT_RESOURCE_ALIAS SettingsDialog.qml
)

qt_add_qml_module(EQ-RSS-Reader
    URI EQRSS
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/HeaderBar.qml
        qml/ReaderWorkspace.qml
        qml/ArticleRenderer.qml
        qml/FeedSidebar.qml
        qml/ManagementSidebar.qml
        qml/AppIcon.qml
        qml/AppStyle.qml
        qml/SettingsDialog.qml
)

qt_add_resources(EQ-RSS-Reader app_assets
    PREFIX "/"
    BASE resources
    FILES resources/eq-rssnews.svg
)

if(WIN32)
    set_target_properties(EQ-RSS-Reader PROPERTIES
        WIN32_EXECUTABLE TRUE
        OUTPUT_NAME "EQ-RSS-Reader"
    )
endif()

file(GLOB_RECURSE EQ_RSS_ICON_THEME_FILES CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_SOURCE_DIR}/resources/icons/eq/*"
)
qt_add_resources(EQ-RSS-Reader eq_icon_theme
    PREFIX "/icons"
    BASE resources/icons
    FILES ${EQ_RSS_ICON_THEME_FILES}
)
