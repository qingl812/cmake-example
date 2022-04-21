#!/bin/bash
source scripts/build_all.sh

# exit if error
set -e

build_dir="build"
project_name="cmake-example"
cxx_compiler="msvc"
log_file="${build_dir}/build.log"

# clean
if [ "$1" == "clean" ]; then
    clean ${build_dir} ${log_file}
    exit 0
elif [ "$1" == "rebuild" ]; then
    clean ${build_dir} ${log_file}
fi

# build all
# {project_name} {build_dir} {log_file} {cxx_compiler}
build ${project_name} ${build_dir} ${log_file} ${cxx_compiler}
