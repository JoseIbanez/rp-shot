#/!bin/bash


#Add AC3 stream

ffprobe "$IFILE"
ffprobe /mnt/mtmp/ofile.mkv


ffmpeg   -t 30 -i "$IFILE" \
  -map 0:v -map 0:a:0 -map 0:a -map 0:s \
  -c:v copy -c:a copy -c:s copy \
  -c:a:0 ac3 -b:a:0 640k \
  /mnt/mtmp/ofile.mkv


