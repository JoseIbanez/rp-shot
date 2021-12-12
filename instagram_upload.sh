#!/bin/bash

convert -define jpeg:size=1280x1280 -resize 640x640^ \
    -extent 640x640 /tmp/original.jpg /tmp/square.jpg

