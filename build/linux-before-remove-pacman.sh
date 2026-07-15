#!/bin/bash

if [ -d /run/systemd/system ]; then
    systemctl disable --now sing-box-daemon-reF1nd.service || true
fi
