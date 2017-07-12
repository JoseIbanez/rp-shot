#!/bin/bash

/usr/local/bin/aws s3 sync /media/pic/ s3://ibanez.j/pic/p2/ --storage-class REDUCED_REDUNDANCY  >> /tmp/sync.log 2>&1

