#!/bin/bash

set -euo pipefail

CORE_COUNT="$(nproc)"
RELEASE_DIR='/build/release'

function build_hello() {
    local EXAMPLES_DIR='/src/examples'
    local EXAMPLE_RELEASE_DIR="${RELEASE_DIR}/hello"

    mkdir -p ${EXAMPLE_RELEASE_DIR}

    cd ${EXAMPLES_DIR}/hello
    mkdir -p build && cd build
    cmake ..
    cmake --build . --parallel ${CORE_COUNT}

    cp hello ${EXAMPLE_RELEASE_DIR}/hello-armv7
}

function main() {
    mkdir -p ${RELEASE_DIR}

    build_hello
}

main
