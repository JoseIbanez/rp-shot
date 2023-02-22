#!/bin/bash

export TARGET_PATH=/mnt/d2/tl/202301-Roble.12/

find $TARGET_PATH | sort |  \
   xargs -P8 -I {} \
   convert {} -colorspace gray -format "%[basename],%[mean],%[standard_deviation],%[entropy]\n" info:


echo "---"

#find $TARGET_PATH | sort |  \
#   xargs -n1 -I {} \
#   convert {} -colorspace gray -format "%[basename],%[mean]\n" info:
#echo "---"

