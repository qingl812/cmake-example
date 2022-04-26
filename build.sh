#!/bin/bash
source scripts/build.sh

# exit if error
set -e

build_dir="build"
project_name="cmake-example"
test_project_name="cmake-example-test"
cxx_compiler="msvc"
log_file="${build_dir}/build.log"

# clean
if [ "$1" == "clean" ]; then
    clean ${build_dir} ${log_file}
elif [ "$1" == "rebuild" ]; then
    clean ${build_dir} ${log_file}
    build ${project_name} ${build_dir} ${log_file} ${cxx_compiler}
elif [ "$1" == "test" ]; then
    build_test ${test_project_name} ${build_dir} ${log_file} ${cxx_compiler}
else
    build ${project_name} ${build_dir} ${log_file} ${cxx_compiler}
fi
