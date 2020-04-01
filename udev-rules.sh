#!/bin/bash

/usr/lib/libgphoto2/print-camera-list udev-rules version 0.98 group plugdev mode 0660 \
    > /etc/udev/rules.d/90-libgphoto2.rules
