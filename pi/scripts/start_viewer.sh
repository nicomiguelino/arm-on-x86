#!/bin/bash

set -euo pipefail

function start_x_server() {
    # Start X server in the background without cursor without sleep
    X -nocursor -noreset :0 &
}

function main() {
    start_x_server
    sleep 2
    xset s off -dpms
    BROWSER_URL='https://anthias.screenly.io/' webengine2
}

main
