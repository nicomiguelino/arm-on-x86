#!/bin/bash

set -euo pipefail

CORE_COUNT="$(nproc)"

function build_hello() {
    local EXAMPLES_DIR='/src/examples'

    cd ${EXAMPLES_DIR}/hello
    mkdir -p build && cd build
    cmake ..
    cmake --build . --parallel ${CORE_COUNT}

    cp hello ${RELEASE_DIR}/hello-armv7
}

function main() {
    local RELEASE_DIR='/build/release'
    mkdir -p ${RELEASE_DIR}

    build_hello
}

main
