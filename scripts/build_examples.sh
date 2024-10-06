#!/bin/bash

set -euo pipefail

CORE_COUNT="$(nproc)"
EXAMPLES_DIR='/src/examples'
RELEASE_DIR='/build/release'

EXAMPLE="${EXAMPLE:-dbus-1}"

function build_hello() {
    echo "Building the hello example..."
    local EXAMPLE_RELEASE_DIR="${RELEASE_DIR}/hello"
    mkdir -p ${EXAMPLE_RELEASE_DIR}

    cd ${EXAMPLES_DIR}/hello

    mkdir -p build && cd build
    cmake ..
    cmake --build . --parallel ${CORE_COUNT}

    cp hello ${EXAMPLE_RELEASE_DIR}/hello-armv7
}

function build_dbus_1() {
    echo "Building the ping-pong D-Bus example..."
    local EXAMPLE_RELEASE_DIR="${RELEASE_DIR}/pingpong"
    local ARCHIVE_NAME='pingpong-armv7.tar.gz'
    mkdir -p ${EXAMPLE_RELEASE_DIR}

    cd ${EXAMPLES_DIR}/pingpong

    mkdir -p build && cd build
    cmake ..
    cmake --build . --parallel ${CORE_COUNT}

    # Package the executables as tarballs.
    tar -czf ${EXAMPLE_RELEASE_DIR}/${ARCHIVE_NAME} ping pong

    cd ${EXAMPLE_RELEASE_DIR}
    sha256sum ${ARCHIVE_NAME} > ${ARCHIVE_NAME}.sha256
}

function main() {
    mkdir -p ${RELEASE_DIR}

    if [ "${EXAMPLE}" == "hello" ]; then
        build_hello
    elif [ "${EXAMPLE}" == "dbus-1" ]; then
        build_dbus_1
    else
        echo "Unknown example: ${EXAMPLE}"
        exit 1
    fi
}

main
