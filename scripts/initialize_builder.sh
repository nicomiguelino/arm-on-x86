#!/bin/bash

set -euo pipefail

PLATFORM=${PLATFORM:-'arm64'}
BUILDX_ARGS=(
    '-f' "docker/Dockerfile.${PLATFORM}"
    '-t' 'qt6-builder'
)

if [ "${PLATFORM}" = 'arm64' ]; then
    BUILDX_ARGS+=(
        '--platform' 'linux/arm64/v8'
    )
elif [ "${PLATFORM}" == 'armv7' ]; then
    BUILDX_ARGS+=(
        '--platform' 'linux/arm/v7'
    )
elif [ "${PLATFORM}" = 'armv6' ]; then
    BUILDX_ARGS+=(
        '--platform' 'linux/arm/v6'
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
