#!/bin/bash

scriptHome=/home/ibanez/Projects/rp-shot

cd $scriptHome

rm -f /tmp/*.jpg

title1="TL A300 Roble"
path1="/mnt/d2/tl/202112-Roble/"


ofile=`find "$path1" -mmin -30 -name "a300b*" | tail -n 1`
convert $ofile -quality 80 /tmp/a300.jpg

ofile=`find /mnt/d2/tl/202112-Roble/ -mmin -30 -name "d5300*" | tail -n 1`
convert $ofile -quality 80 /tmp/d5300.jpg

ls -lh /tmp/a300.jpg
ls -lh /tmp/d5300.jpg


./twitter_upload.py -text "$title1" -file  /tmp/a300.jpg
sleep 10
./twitter_upload.py -text "TL D5300 Roble" -file  /tmp/d5300.jpg

