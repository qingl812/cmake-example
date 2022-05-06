cmake_minimum_required(VERSION 3.16.3)
project(cmake-example)

# Set the compiler options
set(CMAKE_CXX_STANDARD 11)
# msvc or gcc
if(MSVC)
add_compile_options("/utf-8")
else()
set(CMAKE_CXX_FLAGS "-g -O0 -Wall -coverage")
endif()

SET(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin)

set(
    PROJECT_SOURCES
    # header files
    "include/example.h"

    # source files
    "src/example.cpp"
    "src/main.cpp"
)
include_directories("include")

add_executable(${PROJECT_NAME} ${PROJECT_SOURCES})

enable_testing()
add_subdirectory(test)
