#!/bin/bash

set -euo pipefail

function main() {
    PLATFORMS=(
        "arm64"
        "armv7"
    )

    for PLATFORM in "${PLATFORMS[@]}"; do
        echo "Building examples for platform: ${PLATFORM}"
        ./scripts/initialize_builder.sh
        docker exec -it qt6-builder-container \
            bash -c "PLATFORM=$PLATFORM /scripts/build_examples.sh"
    done
}

main
