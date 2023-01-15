#!/bin/bash

ssh pi@192.168.1.102 /home/pi/Projects/rp-iot/p08-serialBT/timelapse.v2.sh


cd /media/pic/
sudo gphoto2 --capture-image-and-download


#DATE=$(date +"%Y-%m-%d_%H%M")


