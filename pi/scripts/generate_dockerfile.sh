#!/bin/bash

set -euo pipefail

export BASE_IMAGE_TAG="bookworm"
export TARGET_DEVICE=${TARGET_DEVICE:-"pi4"}

DOCKERFILE_TEMPLATE_PATH="docker/Dockerfile.pi.template"
DOCKERFILE_PATH="docker/Dockerfile.pi"

if [[ ! $TARGET_DEVICE =~ ^(pi1|pi2|pi3|pi4)$ ]]; then
    echo "Invalid target device: $TARGET_DEVICE"
    echo "Supported devices: pi1, pi2, pi3, pi4"
    exit 1
fi

function main() {
    if [[ "$TARGET_DEVICE" == "pi1" ]]; then
        export BASE_IMAGE_NAME="balenalib/raspberry-pi"
    elif [[ "$TARGET_DEVICE" == "pi2" ]]; then
        export BASE_IMAGE_NAME="balenalib/raspberry-pi2"
    elif [[ "$TARGET_DEVICE" == "pi3" ]]; then
        export BASE_IMAGE_NAME="balenalib/raspberrypi3-debian"
    elif [[ "$TARGET_DEVICE" == "pi4" ]]; then
        export BASE_IMAGE_NAME="balenalib/raspberrypi3-debian"
    fi

    local RELEASES_URL="https://github.com/nicomiguelino/arm-on-x86/releases"
    local RELEASE_TAG="v0.0.5"
    local DOWNLOAD_URL_PREFIX="${RELEASES_URL}/download/${RELEASE_TAG}"

    if [[ $TARGET_DEVICE =~ ^(pi2|pi3|pi4)$ ]]; then
        local PLATFORM="armv7"
    else
        local PLATFORM="armv6"
    fi

    export ARCHIVE_NAME="pingpong-${PLATFORM}.tar.gz"
    export DOWNLOAD_URL="${DOWNLOAD_URL_PREFIX}/${ARCHIVE_NAME}"

    cat ${DOCKERFILE_TEMPLATE_PATH} | envsubst > ${DOCKERFILE_PATH}
}

main
