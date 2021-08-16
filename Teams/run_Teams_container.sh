#!/bin/bash


sudo chmod -R 777 *

sudo apt install -y docker.io

sudo apt install -y docker-compose

sudo docker build -t local/teamsxserv:0.0.1 .

#sudo docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" local/zoomxserv:0.0.1 


#export DISPLAY="192.168.0.14:7.0"

#enable this for azure case
#export DISPLAY=10.0.0.5:10.0
#export DISPLAY=10.0.0.5:10.0

#enable this for localhost case
#export DISPLAY=":1"

export DISPLAY=$DISPLAY

sudo docker start teamsxserv
#sudo docker run --entrypoint /bin/sh 
#sudo docker run -itd --entrypoint /usr/bin/teams --name teamsxserv local/teamsxserv:0.0.1 
#demo-Virtual-Machine

sudo apt install -y pulseaudio alsa-utils paprefs

#If entrypoint is bash then run teams or /usr/bin/teams to start the teams application.

sudo docker run -it --entrypoint /bin/bash --device /dev/snd -v /dev/snd:/dev/snd -v /dev/video0:/dev/video0 --network host --privileged --memory 6000mb -e VNC_SERVER_PASSWORD=password --user apps -e DISPLAY=$DISPLAY -v $HOME/Downloads:/home/apps/Downloads --shm-size=3G -v /run/dbus/:/run/dbus/ -v /dev/shm:/dev/shm -v /tmp/.X11-unix:/tmp/.X11-unix --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  --name teamsxserv local/teamsxserv:0.0.1


#sudo docker run -l info --network host --privileged --memory 6000mb -e VNC_SERVER_PASSWORD=password --user apps -e DISPLAY=$DISPLAY -v $HOME/Downloads:/home/apps/Downloads --shm-size=3G -v /dev/shm:/dev/shm -v /tmp/.X11-unix:/tmp/.X11-unix --volume="$HOME/.Xauthority:/root/.Xauthority:rw"  --name teamsxserv local/teamsxserv:0.0.1 
#-p 3389:3389

#sudo docker start chromexserv

