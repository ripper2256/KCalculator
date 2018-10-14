cmake_minimum_required(VERSION 3.1)

project(kcalc)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package (ECM ${KF5_VERSION} REQUIRED NO_MODULE)
set (CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(KDECMakeSettings)
include(ECMMarkAsTest)
include(FeatureSummary)
include(ECMAddAppIcon)
include(ECMSetupVersion)
set (CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" ${CMAKE_SOURCE_DIR}/cmake/modules)

find_package(KF5 REQUIRED COMPONENTS
    Notifications
)


find_package(GMP)
set_package_properties(GMP PROPERTIES
    DESCRIPTION "The GNU Multiple Precision Arithmetic Library"
    URL "http://gmplib.org/"
    TYPE REQUIRED
    PURPOSE "Required for building KCalc."
)

include(CheckTypeSize)
include(CheckIncludeFiles)

check_include_files(ieeefp.h     HAVE_IEEEFP_H)
check_type_size("signed long"    SIZEOF_SIGNED_LONG)
check_type_size("unsigned long"  SIZEOF_UNSIGNED_LONG)

configure_file(config-kcalc.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config-kcalc.h )
include_directories( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/knumber ${GMP_INCLUDE_DIR} )

########### next target ###############
# Needs absolute paths due to the test program for knumber
set(libknumber_la_SRCS  
	${CMAKE_CURRENT_SOURCE_DIR}/knumber/knumber.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/knumber/knumber_error.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/knumber/knumber_float.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/knumber/knumber_fraction.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/knumber/knumber_integer.cpp
	${CMAKE_CURRENT_SOURCE_DIR}/knumber/knumber_operators.cpp
)

add_subdirectory( knumber )

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

add_executable(${PROJECT_NAME} "main.cpp" "kcalcdisplay.cpp" ${libknumber_la_SRCS} "stats.cpp" "kcalc_core.cpp" "qml.qrc")
target_compile_definitions(${PROJECT_NAME} PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(${PROJECT_NAME} PRIVATE Qt5::Core Qt5::Quick ${GMP_LIBRARIES} KF5::Notifications)
