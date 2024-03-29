cmake_minimum_required(VERSION 3.28)

# autoconf.h is generated by Kconfig and placed in <build>/include/generated/autoconf.h.
set(AUTOCONF_H   ${PROJECT_BINARY_DIR}/include/generated/autoconf.h)
set(KCONFIG_ROOT ${CMAKE_SOURCE_DIR}/Kconfig)
set(DOTCONFIG    ${PROJECT_BINARY_DIR}/.config)
include(menuconfig)

get_filename_component(AUTOCONF_DIR ${AUTOCONF_H} DIRECTORY)
file(MAKE_DIRECTORY ${AUTOCONF_DIR})

# CMAKE_CONFIGURE_DEPENDS will only takes existing file
if(NOT EXISTS ${DOTCONFIG})
    file(TOUCH ${DOTCONFIG})
endif()

# Re-configure (Re-execute all CMakeLists.txt code) when autoconf.h changes
set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS ${AUTOCONF_H} ${DOTCONFIG})

include(kconfig_import)
if(EXISTS ${DOTCONFIG})
import_kconfig(CONFIG_ ${DOTCONFIG})
endif()

if(NOT EXISTS "${CMAKE_BINARY_DIR}/autoconf.h")
    message("autoconf.h not found. Please run 'make menuconfig' to generate it.")
endif()
