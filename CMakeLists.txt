cmake_minimum_required(VERSION 3.16.3)
project(cmake-example)

# Set the compiler options
set(CMAKE_CXX_STANDARD 11)
# msvc or gcc
if(MSVC)
add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")
else()
set(CMAKE_CXX_FLAGS "-g -O0 -Wall")
endif()

set(
    PROJECT_SOURCES
    # header files
    "include/example.h"

    # source files
    "src/example.cpp"
)

include_directories("include")

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})
