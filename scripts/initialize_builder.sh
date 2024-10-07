#!/bin/bash

set -euo pipefail

PLATFORM=${PLATFORM:-'armv7'}

if [ "${PLATFORM}" == 'armv7' ]; then
    BUILDX_ARGS=(
        '-f' 'docker/Dockerfile.armv7'
        '--platform' 'linux/arm/v7'
        '-t' 'qt6-builder'
    )
elif [ "${PLATFORM}" = 'armv6' ]; then
    BUILDX_ARGS=(
        '-f' 'docker/Dockerfile.armv6'
        '--platform' 'linux/arm/v6'
        '-t' 'qt6-builder'
    )
else
    echo "Unknown platform: ${PLATFORM}"
    exit 1
fi

RUN_ARGS=(
    '-itd'
    '--name' 'qt6-builder-container'
    '-v' './build:/build'
    '-v' './examples:/src/examples'
    '-v' './scripts/build_examples.sh:/scripts/build_examples.sh'
    '-e' "PLATFORM=${PLATFORM}"
    'qt6-builder'
)

docker buildx build --load "${BUILDX_ARGS[@]}" .
docker rm -f qt6-builder-container || true
docker run "${RUN_ARGS[@]}" bash
