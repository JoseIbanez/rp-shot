#!/bin/bash

export TARGET_PATH=/mnt/d2/tl/202301-Roble.11/

find $TARGET_PATH | sort |  \
   xargs -n1 -I {} \
   convert {} -colorspace gray -format "%[basename],%[mean],%[standard_deviation],%[entropy]\n" info:



find $TARGET_PATH | sort |  \
   xargs -n1 -I {} \
   convert {} -colorspace gray -format "%[basename],%[mean]\n" info:

