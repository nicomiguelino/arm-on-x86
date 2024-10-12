#!/bin/bash

set -euo pipefail

CORE_COUNT="$(nproc)"
EXAMPLES_DIR='/src/examples'
RELEASE_DIR='/build/release'

EXAMPLE="${EXAMPLE:-all}"
PLATFORM="${PLATFORM:-'armv7'}"

function build_hello() {
    echo "Building the hello example..."
    local ARCHIVE_NAME="hello-${PLATFORM}.tar.gz"

    cd ${EXAMPLES_DIR}/hello

    mkdir -p build/${PLATFORM} && cd build/${PLATFORM}
    cmake ../..
    cmake --build . --parallel ${CORE_COUNT}

    # Package the executables as tarballs.
    tar -czf ${RELEASE_DIR}/${ARCHIVE_NAME} hello
    cd ${RELEASE_DIR}
    sha256sum ${ARCHIVE_NAME} > ${ARCHIVE_NAME}.sha256
}

function build_dbus_1() {
    echo "Building the ping-pong D-Bus example..."
    local ARCHIVE_NAME="pingpong-${PLATFORM}.tar.gz"

    cd ${EXAMPLES_DIR}/pingpong

    mkdir -p build/${PLATFORM} && cd build/${PLATFORM}
    cmake ../..
    cmake --build . --parallel ${CORE_COUNT}

    # Package the executables as tarballs.
    tar -czf ${RELEASE_DIR}/${ARCHIVE_NAME} ping pong
    cd ${RELEASE_DIR}
    sha256sum ${ARCHIVE_NAME} > ${ARCHIVE_NAME}.sha256
}

function build_webengine_1() {
    echo "Building the a simple content manipulation webengine example..."
    local ARCHIVE_NAME="webengine-1-${PLATFORM}.tar.gz"

    cd ${EXAMPLES_DIR}/webengine_1

    mkdir -p build/${PLATFORM} && cd build/${PLATFORM}
    cmake ../..
    cmake --build . --parallel ${CORE_COUNT}

    # Package the executables as tarballs.
    tar -czf ${RELEASE_DIR}/${ARCHIVE_NAME} contentmanipulation
    cd ${RELEASE_DIR}
    sha256sum ${ARCHIVE_NAME} > ${ARCHIVE_NAME}.sha256
}

function build_webengine_2() {
    echo "Building the a simple content manipulation webengine example..."
    local ARCHIVE_NAME="webengine-2-${PLATFORM}.tar.gz"

    cd ${EXAMPLES_DIR}/webengine_2

    mkdir -p build/${PLATFORM} && cd build/${PLATFORM}
    cmake ../..
    cmake --build . --parallel ${CORE_COUNT}

    # Package the executables as tarballs.
    tar -czf ${RELEASE_DIR}/${ARCHIVE_NAME} webengine2
    cd ${RELEASE_DIR}
    sha256sum ${ARCHIVE_NAME} > ${ARCHIVE_NAME}.sha256
}

function main() {
    mkdir -p ${RELEASE_DIR}

    if [ "${EXAMPLE}" == "hello" ]; then
        build_hello
    elif [ "${EXAMPLE}" == "dbus-1" ]; then
        build_dbus_1
    elif [ "${EXAMPLE}" == "webengine-1" ]; then
        build_webengine_1
    elif [ "${EXAMPLE}" == "webengine-2" ]; then
        build_webengine_2
    elif [ "${EXAMPLE}" == "all" ]; then
        build_hello
        build_dbus_1
        build_webengine_1
        build_webengine_2
    else
        echo "Unknown example: ${EXAMPLE}"
        exit 1
    fi
}

main
