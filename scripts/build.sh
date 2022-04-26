#!/bin/bash
source scripts/functions.sh

# init
function init() {
    project_name=$1
    build_dir=$2
    log_file=$3
    cxx_compiler=$4

    # if linux and cxx_compiler==msvc, use gcc
    system=$(get_system_name)
    if [ ${system} == "linux" ] && [ "$cxx_compiler" == "msvc" ]; then
        cxx_compiler="gcc"
    fi

    # mkdir if not exist
    mkdir_if_not_exist ${build_dir}

    # remove old log file
    if [ -f ${log_file} ]; then
        rm ${log_file}
    fi

    # msvc
    if [ "${cxx_compiler}" == "msvc" ]; then
        exe_file="${build_dir}/Debug/${project_name}"
        test_exe_file="${build_dir}/test/Debug/${project_name}"
    else
        exe_file="${build_dir}/${project_name}"
        test_exe_file="${build_dir}/test/${project_name}"
    fi

    # windows
    if [ get_system_name == "windows" ]; then
        exe_file="${exe_file}.exe"
        test_exe_file="${test_exe_file}.exe"
    fi
}

# {build_dir} {log_file}
function clean() {
    # need 2 argu
    if [ $# -ne 2 ]; then
        exit_with_error "Usage: clean {build_dir} {log_file}"
    fi

    # remove old log file
    if [ -f $2 ]; then
        rm $2
    fi

    # remove old build directory
    if [ -d $1 ]; then
        rm -rf $1
    fi
}

# {project_name} {build_dir} {log_file} {cxx_compiler}
function build() {
    # need 4 argu
    if [ $# -ne 4 ]; then
        exit_with_error "Usage: build {project_name} {build_dir} {log_file} {cxx_compiler}"
    fi

    init $1 $2 $3 $4

    # cmake
    run_no_error bash scripts/cmake.sh ${log_file} ${build_dir} ${cxx_compiler}

    # Execute the generated program
    print_info "Running ${exe_file}..."
    ${exe_file}
    if [ $? -ne 0 ]; then
        print_error "${exe_file} return code is $?"
        exit 1
    fi
}

# {test_project_name} {build_dir} {log_file} {cxx_compiler}
function build_test() {
    # need 4 argu
    if [ $# -ne 4 ]; then
        exit_with_error "Usage: build {test_project_name} {build_dir} {log_file} {cxx_compiler}"
    fi

    init $1 $2 $3 $4

    # cmake
    run_no_error bash scripts/cmake.sh ${log_file} ${build_dir} ${cxx_compiler}

    # Execute the generated program
    print_info "Running ${test_exe_file}..."
    ${test_exe_file}
    if [ $? -ne 0 ]; then
        print_error "${test_exe_file} return code is $?"
        exit 1
    fi
}

function code_coverage() {
    # need 3 argu
    if [ $# -ne 3 ]; then
        exit_with_error "Usage: lcov.sh {build_dir} {lcov_dir} {log_file}"
    fi

    # Currently only supports linux
    system=$(get_system_name)
    if [ ${system} == "linux" ]; then
        run_no_error bash scripts/lcov.sh $1 $2 $3
    else
        print_error "Currently only supports Linux generating code coverage report."
    fi
}
