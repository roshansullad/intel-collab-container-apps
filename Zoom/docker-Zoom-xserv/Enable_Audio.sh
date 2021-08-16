#!/bin/bash
# Cleanup to be "stateless" on startup, otherwise pulseaudio daemon can't start
sudo rm -rf /var/run/pulse /var/lib/pulse /root/.config/pulse

# Start pulseaudio as system wide daemon; for debugging it helps to start in non-daemon mode
echo "Pulseaudio setting flags: ";
sudo pulseaudio -D --verbose --exit-idle-time=-1 --system --disallow-exit --disallow-module-loading

# Create a virtual audio source; fixed by adding source master and format
echo "Creating virtual audio source: ";
sudo pactl load-module module-virtual-source master=auto_null.monitor format=s16le source_name=VirtualMic

# Set VirtualMic as default input source;
echo "Setting default source: ";
sudo pactl set-default-source VirtualMic

#/usr/bin/zoom
# whatever you'd like to do next
# e.g. npm run start
