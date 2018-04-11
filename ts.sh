#!/bin/bash

DATE=$(date +"%Y-%m-%d_%H%M")

#raspistill -rot 90 -o /media/pic/$DATE.jpg
raspistill -rot 180 -o /media/pic/$DATE.jpg

