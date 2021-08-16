#!/bin/bash


sudo chmod -R 777 *

sudo apt install -y docker.io

sudo apt install -y docker-compose

sudo docker build -t local/zoomxserv:0.0.1 .

#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" local/zoomxserv:0.0.1 


#export DISPLAY="192.168.0.14:7.0"

#enable this for azure case
#export DISPLAY=10.0.0.5:10.0
#export DISPLAY=10.0.0.5:10.0

#enable this for localhost case especially VM, Disable this on local host machine
#export DISPLAY=":1"

export DISPLAY=$DISPLAY

sudo apt install -y pulseaudio alsa-utils paprefs
#sudo xhost +local:docker
#sudo xhost+

#alsamixer
sudo docker start zoomxserv

#-ti 
#pactl list clients
# --entrypoint /bin/bash

sudo docker run -it --entrypoint /bin/bash --device /dev/snd -v /dev/snd:/dev/snd -v /dev/video0:/dev/video0 --network host --privileged --memory 6000mb -e VNC_SERVER_PASSWORD=password --user apps -e DISPLAY=$DISPLAY -v $HOME/Downloads:/home/apps/Downloads --shm-size=3G -v /run/dbus/:/run/dbus/ -v /dev/shm:/dev/shm -v /tmp/.X11-unix:/tmp/.X11-unix --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  --name zoomxserv local/zoomxserv:0.0.1

#working code
#sudo docker run -it --network host --privileged --memory 4000mb -e VNC_SERVER_PASSWORD=password --user apps -e DISPLAY=$DISPLAY -v $HOME/Downloads:/home/apps/Downloads --shm-size=3G -v /dev/shm:/dev/shm -v /tmp/.X11-unix:/tmp/.X11-unix --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  --name zoomxserv local/zoomxserv:0.0.1 #-p 3389:3389


#sudo docker start chromexserv

