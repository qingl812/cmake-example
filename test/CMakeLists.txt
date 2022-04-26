cmake_minimum_required(VERSION 3.16.3)

project(cmake-example-test)

set(
  TEST_SOURCES
  "../src/example.cpp"

  "test.cpp"
)

# gtest
include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://file.winterwonder.top/public/package/googletest-release-1.11.0.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

add_executable(${PROJECT_NAME} ${TEST_SOURCES})

target_link_libraries(
  ${PROJECT_NAME}
  gtest_main
)

include(GoogleTest)
gtest_discover_tests(${PROJECT_NAME})
