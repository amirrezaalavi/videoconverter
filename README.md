# What is this?
This is a simple script for changing encoding of videos in batch. I usually use ffmpeg to change the encoding of my videos. (Some times) this will help reduce Video size. But encoding is a tricky work and might take a lot of time and processing power, so using a gpu accelerator to reduce the time significantly. This script will help you change encoding of multiple videos in a directory at once with your encoder of choice.

# Usage
- ## Requirments
Based on your gpu, you have some acceleration options. Propritary encoders are usually more efficient and faster. this script is specifically using these Encoders:
| Name | Targeted Hardware |
|:------|:------:|
|qsv|Intel GPU(iGPU on 8th gen and later)|
|nvenc|Nvidia GPU|
|amf|Amd GPU|
|videotoolbox|Apple Silicon|
|libx265|CPU|

- ## Installation
For encoders on Linux distros, you need non-free mirrors. For Debian/Ubuntu you can edit `/etc/apt/sources.list`. For SUSE Based distros you can add [Packman](https://en.opensuse.org/Additional_package_repositories).
Then clone the project Using `git clone https://github.com/amirrezaalavi/videoconverter.git` and run the script using `./converter.sh`.
> If you get permission errors, you can fix it with `chmod u+x converter.sh`.
- ## Using
Run the script, enter the directory you put videos inside, then select available encoder Usually I prefer h.264 for lower quality and h.265 for higher quality videos. The rest will be handled by the script, But you can edit the quality by hand inside the script.
> Be careful as the higher quality means more time to compress and more size.
