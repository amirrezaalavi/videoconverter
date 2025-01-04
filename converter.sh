#!/bin/bash

# Grab all encoders for Nvidia, Intel And Amd
ffmpeg -encoders | grep amf > enc
ffmpeg -encoders | grep qsv > enc
ffmpeg -encoders | grep nvenc > enc

echo enc
# Choose encoder
echo "Which encoder would you choose? :"
read encoder

# qsv accepts global_quality instead of crf, for now the number is not optional
if[${encoder: -3} == "qsv"]; then
    quality_parameter = '-global_quality 22'
else
    quality_parameter = '-crf 23'
fi
echo "Using directory $(pwd)"


for file in *; do
    # Check if it is a regular file
    if [ -f "$file" ]; then
        # Save the full name into a variable, for overwriting
        # full_name="$file"

        # Convert the file to H.265 with AAC 128k using $encoder, for now audio is not optional
        ffmpeg -i "$full_name" -c:v $encoder $quality_parameter -c:a aac "${full_name%.*}_converted.mp4"

        # Move the converted file to the original name (overwriting), maybe allowing this in future
        # mv "${full_name%.*}_converted.mp4" "$full_name"
    fi
done
