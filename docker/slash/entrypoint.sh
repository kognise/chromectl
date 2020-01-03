#!/bin/bash
set -e

IFS='x' read SCREEN_WIDTH SCREEN_HEIGHT <<< "${VNC_SCREEN_SIZE}"

export VNC_SCREEN="${SCREEN_WIDTH}x${SCREEN_HEIGHT}x24"
export CHROME_WINDOW_SIZE="${SCREEN_WIDTH},${SCREEN_HEIGHT}"
export CHROME_OPTS="${CHROME_OPTS_OVERRIDE:- --user-data-dir --no-sandbox --window-position=0,0 --force-device-scale-factor=1}"

exec "$@"