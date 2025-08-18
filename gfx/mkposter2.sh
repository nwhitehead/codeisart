#!/bin/env bash

#    -filter_complex "[0:v][1:v] scale=320:-1:flags=lanczos overlay=0:0" \
#    -pix_fmt rgb8 \

ffmpeg \
    -y \
    -i poster2.png \
    -i clouds.webm \
    -loop 0 \
    -filter_complex "[0:v]scale=400:-1[txt];[1:v]scale=400:-1[cld];[txt][cld]overlay=0:350[ovr]" \
    -map '[ovr]' \
    -pix_fmt rgb8 \
    poster2.gif \
&& eog poster2.gif
