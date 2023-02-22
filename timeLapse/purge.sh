#!/bin/bash

find /media/pic/ -mmin +1000 -delete

 cat image_list.csv | sort -k 2  -t, -n | tail -n 80 | cut -d, -f1 > bb.lst 
 cat bb.lst | xargs -I {} mv $TARGET_PATH{}.jpg $TARGET_PATH../review/

 
 