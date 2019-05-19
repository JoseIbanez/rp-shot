#!/bin/bash

scriptHome=/home/ibanez/Projects/rp-shot

cd $scriptHome

rm -f /tmp/*.jpg

ofile=`find /mnt/d2/tl/201905-Albahaca/ -mmin -30 -name "a300*" | tail -n 1`
convert $ofile -quality 80 /tmp/a300.jpg

ofile=`find /mnt/d2/tl/201905-Albahaca/ -mmin -30 -name "d5300*" | tail -n 1`
convert $ofile -quality 80 /tmp/d5300.jpg

ls -lh /tmp/a300.jpg
ls -lh /tmp/d5300.jpg


./twitter_upload.py -text "TL A300 Albahaca" -file  /tmp/a300.jpg
sleep 10
./twitter_upload.py -text "TL D5300 Albahaca" -file  /tmp/d5300.jpg
