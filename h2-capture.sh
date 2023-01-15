#!/bin/bash

echo "go home"
cd /home/ibanez/Projects/rp-shot/

old=""
#topic="q/ESP3C71BF51A064"
#topic="q/ESP60019440E65A"
topic="q/ESP2C3AE8128E75"

export photoPath_D5300=/mnt/d2/tl/202301-Roble
export photoPath_A300Black=/mnt/d2/tl/202301-Black
export photoPath_A300Red=/mnt/d2/tl/202301-Red
export photoPath_WebCam=/mnt/d2/tl/202301-WebCam



##############
echo "Turn on the lights"
mosquitto_pub -h 192.168.1.19 -t  $topic -m "0001;1111"
sleep 2
#mosquitto_pub -h 192.168.1.19 -t  $topic -m "0001;1111"
sleep 2
mosquitto_pub -h 192.168.1.19 -t  $topic -m "0060;1111"
sleep 7

#################

#d5300 config
echo "Configure D5300"
sudo gphoto2 --camera "Nikon DSC D5300" --set-config /main/capturesettings/imagequality=2
sudo gphoto2 --camera "Nikon DSC D5300" --set-config /main/capturesettings/flashmode=0

# Serial Numbers 
lsusb -v -d 04b0:0363 | grep -B 20 'iSerial' | grep -e iSerial -e "Bus.*Device"


#################

mkdir -p $photoPath_D5300
cd $photoPath_D5300

echo "Capture D5300"
pwd
sudo gphoto2 --capture-image-and-download --camera "Nikon DSC D5300"        --filename 'd5300-%Y%m%d-%H%M%S.jpg'


#################

mkdir -p $photoPath_A300Black
cd $photoPath_A300Black

echo "Capture A300 - 1 Back"
pos=`lsusb -v -d 04b0:0363 | grep -B 20 'iSerial.*000041066942' | grep "Bus.*Device.*Nikon " | sed 's/.*Device \([0-9]*\): ID.*/\1/'`
echo $pos
if [ ! -z "$pos" ]; then
  sudo gphoto2 --capture-image-and-download --port usb:001,$pos --filename 'a300b-%Y%m%d-%H%M%S.jpg'
fi


#################

mkdir -p $photoPath_A300Red
cd $photoPath_A300Red

echo "Capture A300 - 2 Red"
pos=`lsusb -v -d 04b0:0363 | grep -B 20 'iSerial.*000043009524' | grep "Bus.*Device.*Nikon " | sed 's/.*Device \([0-9]*\): ID.*/\1/'`
echo $pos
if [ ! -z "$pos" ]; then
  sudo gphoto2 --capture-image-and-download --port usb:001,$pos --filename 'a300r-%Y%m%d-%H%M%S.jpg'
fi


#######################

#echo "Other light"
#mosquitto_pub -h 192.168.1.19 -t  $topic -m "0030;0010"
#sleep 1

mkdir -p $photoPath_WebCam
cd $photoPath_WebCam

echo "Webcam"
name=`date  +webcam-%Y%m%d-%H%M%S`
sudo fswebcam -d /dev/video0 -r 1920x1080 "$name-0.jpg"
sudo fswebcam -d /dev/video2 -r 1920x1080 "$name-2.jpg"


###############

mosquitto_pub -h 192.168.1.19 -t $topic -m "0000;0000"


