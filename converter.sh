#!/bin/bash

function handle_intrupt {
    echo "stopping the process \n"
    exit 1
}

# Grab all encoders for Nvidia, Intel And Amd
ffmpeg -hide_banner -loglevel error -encoders | grep -Eo '\w*nvenc|\w*amf|\w*qsv|libx265'
echo $enc
# Choose encoder
echo "Which encoder would you choose? :"
read encoder
proceed=true

# qsv accepts global_quality instead of crf, for now the number is not optional
if [ ${encoder: -3} == "libx265" ]; then
    quality_parameter='-crf 23' # libx265 uses -crf , 23 is a normal value for good compression

elif [ grep -o "$encoder" $enc == "" ]; then
    echo "wrong encoder"
    proceed=false

else
    quality_parameter='-global_quality 22' # proprietary encoders use -global_quality , 22 is a good value
fi

if [ $proceed == true ]; then # Does not continue in case a problem is made
    echo "Using directory $(pwd)"
    trap handle_intrupt SIGINT # Intrrupt will only stop one round of loop, with trap you can completely stop the script 
    for file in *; do
        # Check if it is a regular file
        if [ -f "$file" ] && [ $proceed == true ] ; then 
            # Save the full name into a variable, for overwriting
            # full_name="$file"

            # Convert the file to H.265 with AAC 128k using $encoder, for now audio is not optional
            ffmpeg -i "$full_name" -c:v $encoder $quality_parameter -c:a aac "${full_name%.*}_converted.mp4"

            # Move the converted file to the original name (overwriting), maybe allowing this in future
            # mv "${full_name%.*}_converted.mp4" "$full_name"
        fi
    done
fi