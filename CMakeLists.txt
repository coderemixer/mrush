cmake_minimum_required(VERSION 3.15)
project(mrush C)

set(CMAKE_C_STANDARD 11)

if (${CMAKE_C_COMPILER_ID} STREQUAL "Clang")
    set(MRUBY_TOOLCHAIN "clang")
else ()
    SET(MRUBY_TOOLCHAIN "gcc")
endif ()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/mruby/include)

add_custom_target(mruby MRUBY_TOOLCHAIN=${MRUBY_TOOLCHAIN}
        MRUBY_CONFIG=${CMAKE_CURRENT_SOURCE_DIR}/misc/mruby_config.rb
        MRUBY_BUILD_DIR=${CMAKE_CURRENT_BINARY_DIR}/mruby
        MRUBY_ADDITIONAL_CONFIG=${MRUBY_ADDITIONAL_CONFIG} ruby minirake
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/thirdparty/mruby)

add_executable(mrush main.c)

target_link_libraries(mrush
        "${CMAKE_CURRENT_BINARY_DIR}/mruby/host/lib/libmruby.a"
        "m")

add_dependencies(mrush mruby)
