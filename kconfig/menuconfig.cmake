
find_package(BISON)
find_package(FLEX)

BISON_TARGET(Parser ${CMAKE_CURRENT_LIST_DIR}/parser.y parser.tab.c DEFINES_FILE parser.tab.h)
FLEX_TARGET(Scanner ${CMAKE_CURRENT_LIST_DIR}/lexer.l lexer.lex.c)
ADD_FLEX_BISON_DEPENDENCY(Scanner Parser)

set(MENUCONFIG_COMMON_C ${CMAKE_CURRENT_LIST_DIR}/confdata.c ${CMAKE_CURRENT_LIST_DIR}/expr.c ${CMAKE_CURRENT_LIST_DIR}/preprocess.c ${CMAKE_CURRENT_LIST_DIR}/symbol.c ${CMAKE_CURRENT_LIST_DIR}/util.c)
list(APPEND MENUCONFIG_COMMON_C ${FLEX_Scanner_OUTPUTS} ${CMAKE_CURRENT_BINARY_DIR}/${BISON_Parser_OUTPUT_SOURCE} )
file(GLOB_RECURSE MCONF_SRC ${CMAKE_CURRENT_LIST_DIR}/lxdialog/*.c)

add_executable(mconf ${CMAKE_CURRENT_LIST_DIR}/mconf.c ${MENUCONFIG_COMMON_C} ${MCONF_SRC})
target_compile_definitions(mconf PRIVATE -DYYDEBUG)
target_include_directories(mconf PRIVATE ${CMAKE_CURRENT_LIST_DIR})
target_link_libraries(mconf PRIVATE ncurses)

add_executable(conf ${CMAKE_CURRENT_LIST_DIR}/conf.c ${MENUCONFIG_COMMON_C})
target_compile_definitions(conf PRIVATE -DYYDEBUG)
target_include_directories(conf PRIVATE ${CMAKE_CURRENT_LIST_DIR})

add_custom_target(menuconfig mconf ${KCONFIG_ROOT} COMMAND conf -s --syncconfig ${KCONFIG_ROOT})
