#!/bin/bash

scriptHome=~/Projects/rp-shot/social-media/
source ~/py-venv/bin/activate

cd $scriptHome

rm -f /tmp/*.jpg

title1="TL D5300 Roble"
path1="/mnt/d2/tl/202301-Roble/"
path2="/mnt/d2/tl/202112-Roble/"

ofile=`find "$path1" -mmin -30 -name "a300b*" | tail -n 1`
convert $ofile -quality 80 /tmp/a300.jpg

ofile=`find "$path1" -mmin -30 -name "d5300*" | tail -n 1`
convert $ofile -quality 80 /tmp/d5300.jpg

ls -lh /tmp/a300.jpg
ls -lh /tmp/d5300.jpg


./twitter_upload.py   -text "$title1" -file  /tmp/d5300.jpg
./mastodon_upload.py  -text "$title1" -file  /tmp/d5300.jpg
#sleep 10
#./twitter_upload.py -text "TL D5300 Roble" -file  /tmp/d5300.jpg
#./instagram_upload.py -text "TL D5300 Roble" -file /tmp/d5300.jpg

