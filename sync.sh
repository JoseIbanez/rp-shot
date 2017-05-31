#!/bin/bash

aws s3 sync /media/pic/ s3://ibanez.j/pic/p2/ >> /tmp/sync.log

