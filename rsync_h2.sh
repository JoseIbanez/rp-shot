#!/bin/bash

export RSYNC_PASSWORD="localPassword!"
rsync -rv /mnt/pic/tl/* rsync://ibanez@192.168.1.20/TimeLapse/

