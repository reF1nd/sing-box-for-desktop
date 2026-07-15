#!/bin/bash

ln -sf /opt/sing-box-reF1nd/sing-box-reF1nd /usr/bin/sing-box-reF1nd

if ! { [[ -L /proc/self/ns/user ]] && unshare --user true; }; then
    chmod 4755 /opt/sing-box-reF1nd/chrome-sandbox || true
else
    chmod 0755 /opt/sing-box-reF1nd/chrome-sandbox || true
fi

if hash update-mime-database 2>/dev/null; then
    update-mime-database /usr/share/mime || true
fi

if hash update-desktop-database 2>/dev/null; then
    update-desktop-database /usr/share/applications || true
fi

if [ -d /run/systemd/system ]; then
    systemctl daemon-reload
    if systemctl cat polkit-agent-helper.socket >/dev/null 2>&1; then
        systemctl start polkit-agent-helper.socket
    fi
    systemctl enable sing-box-daemon-reF1nd.service
    systemctl restart sing-box-daemon-reF1nd.service
else
    echo "systemd is not running, skipping the sing-box service startup"
fi
