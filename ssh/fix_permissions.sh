#!/bin/bash

chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
chmod 644 ~/.ssh/*.pub
chmod 644 ~/.ssh/config
if [[ -e ~/.ssh/authorized_keys ]]; then
    chmod 600 ~/.ssh/authorized_keys
fi

# EOF