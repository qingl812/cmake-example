#!/bin/bash
source scripts/build.sh

project_name="cmake-example"
build_dir="build"
log_file="${build_dir}/build.log"
cxx_compiler="msvc"
# test
test_project_name="cmake-example-test"
code_coverage_dir="${build_dir}/lcov" # 为空则不生成代码覆盖率报告
# server to view code coverage report
server_exe="live-server"
server_argv=(--port=5500 --open=${code_coverage_dir}/html)

# default build
if [ $# -eq 0 ]; then
    arg_1="build"
else
    arg_1=$1
fi

if [ ${arg_1} == "build" ]; then
    build ${project_name} ${build_dir} ${log_file} ${cxx_compiler}

elif [ ${arg_1} == "clean" ]; then
    clean ${build_dir} ${log_file}

elif [ ${arg_1} == "rebuild" ]; then
    clean ${build_dir} ${log_file}
    build ${project_name} ${build_dir} ${log_file} ${cxx_compiler}

elif [ ${arg_1} == "test" ]; then
    build_test ${test_project_name} ${build_dir} ${log_file} ${cxx_compiler}
    if [ "code_coverage_dir" != "" ]; then
        code_coverage ${build_dir} ${code_coverage_dir} ${log_file}
    fi

elif [ ${arg_1} == "coverage_server" ]; then
    version=$(${server_exe} 2>>${log_file})
    if [ $? -ne 0 ]; then
        exit_with_error "${server_exe} not found. Please install ${server_exe}."
    fi
    run_no_error ${server_exe} "${server_argv[@]}"

else
    print_error "Unknown command: ${arg_1}"
fi
