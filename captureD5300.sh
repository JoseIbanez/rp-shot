#!/bin/bash

ssh pi@192.168.1.102 /home/pi/Projects/rp-iot/p08-serialBT/timelapse.v2.sh


cd /media/pic/
#gphoto2 --capture-image-and-download
gphoto2 --capture-image-and-download  --filename 'pic-%Y%m%d%H%M%S.jpg'


#DATE=$(date +"%Y-%m-%d_%H%M")


