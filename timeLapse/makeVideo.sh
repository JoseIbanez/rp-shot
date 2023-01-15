#!/bin/bash
# 20 fps, NikonA300 folder

prefix="a300"
start=1000
rate="30"


path=$1
prefix=$2

echo $path
echo $prefix


rm -rf /tmp/tl/$prefix
mkdir -p /tmp/tl/$prefix
cd /tmp/tl/$prefix

find $path -name "$prefix*" | sort | ~/Projects/rp-shot/timeLapse/followNumbers.py 




ffmpeg -r $rate \
    -f image2 -s 1920x1080 \
    -start_number $start -i pic-%04d.jpg  \
    -c:v libx264 \
    -profile:v baseline -level 3.0 \
    -pix_fmt yuv420p \
    /mnt/d2/tl/videos/tl-$prefix-$start.$rate.fps.mp4

