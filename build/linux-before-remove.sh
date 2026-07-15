#!/bin/bash

case "$1" in
    remove | 0)
        if [ -d /run/systemd/system ]; then
            systemctl disable --now sing-box-daemon-reF1nd.service || true
        fi
        ;;
esac
