#!/bin/bash

for i in {1..10000}
do
	DATE=$(date +"%Y%m%d-%H%M%S")
	raspistill -o /media/pic/$DATE.jpg
	echo $DATE
	sleep 10
done


