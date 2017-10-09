#!/bin/bash

chmod 700 ~/.ssh
chmod 644 ~/.ssh/*
chmod 600 ~/.ssh/id_rsa
if [[ -e ~/.ssh/authorized_keys ]]; then
    chmod 600 ~/.ssh/authorized_keys
fi

# EOF