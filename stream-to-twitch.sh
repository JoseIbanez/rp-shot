#!/usr/bin/env sh
#
# Stream screen and audio (speakers and microphone) to Twitch.tv using FFmpeg.
#
# Usage: stream-to-twitch path/to/key

set -e

#######################################
# Stream to Twitch.tv.
# Globals:
#   None.
# Arguments:
#   Stream key. A string.
# Returns:
#   None.
#######################################
stream_to_twitch() {
    res_input="1920x1080" # input resolution
    res_output="1280x720" # output resolution
    fps="5" # target FPS
    gop="10" # i-frame interval, should be double of fps
    gop_min="30" # min i-frame interval, should be equal to fps
    probesize="42M" # https://stackoverflow.com/a/57904380
    threads="2" # max 6
    cbr="1000k" # constant bitrate (should be between 1000k–3000k)
    quality="ultrafast" # one of the many FFmpeg presets
    audio_input_speakers="0" # speakers' sink id
    audio_input_mic="default" # microphone's sink id
    audio_rate="44100"
    stream_server="mad.contribute.live-video.net" # see https://stream.twitch.tv/ingests for list
    stream_key="${1}" # key will be passed as an agument from the command line
    #loglevel="warning" # supress unecessary information from printing
    loglevel="info"

    ffmpeg \
        -loglevel "${loglevel}" \
	-f video4linux2 -s "${res_input}" -r ${fps} -probesize ${probesize} -i /dev/video0 \
        -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=44100 \
	-map 0:v -map 1:a\
        -f flv -ac 2 -ar ${audio_rate} \
        -vcodec libx264 -g ${gop} -keyint_min ${gop_min} -b:v ${cbr} \
        -minrate ${cbr} -maxrate ${cbr} -pix_fmt yuv420p \
        -s ${res_output} -preset "${quality}" -tune film -acodec aac \
        -threads ${threads} -strict normal \
        -bufsize ${cbr} \
        "rtmp://${stream_server}/app/${stream_key}"
}

# Get stream key securely stored with the password manager "pass"
# and pass the key to the script to start the stream.
stream_to_twitch "$(pass "${1}")"

