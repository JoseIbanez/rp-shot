#!/bin/bash

echo "go home"
cd /home/ibanez/Projects/rp-shot/

old=""
#topic="q/ESP3C71BF51A064"
#topic="q/ESP60019440E65A"
topic="q/ESP2C3AE8128E75"

echo "Turn on the lights"
#mosquitto_pub -h 192.168.1.19 -t  "q/ESP30AEA4283B74" -m "0060;0001"

mosquitto_pub -h 192.168.1.19 -t  $topic -m "0001;1111"
sleep 2
mosquitto_pub -h 192.168.1.19 -t  $topic -m "0001;1111"
sleep 2
mosquitto_pub -h 192.168.1.19 -t  $topic -m "0060;1111"
sleep 5


#d5300 config
echo "Configure D5300"
sudo gphoto2 --camera "Nikon DSC D5300" --set-config /main/capturesettings/imagequality=2
sudo gphoto2 --camera "Nikon DSC D5300" --set-config /main/capturesettings/flashmode=0


cd /mnt/d2/tl/201911-Encina
echo "Capture D5300"
sudo gphoto2 --capture-image-and-download --camera "Nikon DSC D5300"        --filename 'd5300-%Y%m%d-%H%M%S.jpg'

echo "Capture A300"
sudo gphoto2 --capture-image-and-download --camera "USB PTP Class Camera"   --filename 'a300-%Y%m%d-%H%M%S.jpg'

#echo "Other light"
#mosquitto_pub -h 192.168.1.19 -t  $topic -m "0030;0010"
#sleep 1

#echo "Webcam"
name=`date  +webcam-%Y%m%d-%H%M%S.jpg`
fswebcam -r 1920x1080 $name


mosquitto_pub -h 192.168.1.19 -t $topic -m "0000;0000"


