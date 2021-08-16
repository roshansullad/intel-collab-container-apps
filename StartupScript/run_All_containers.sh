#!/bin/bash


sudo chmod -R 777 *

sudo apt install -y docker.io

sudo apt install -y docker-compose

#This is assuming containers already available locally so just starting those containers on startup.
sudo docker login
sudo docker run roshandoker/container_apps:zoomxserv
sudo docker run roshandoker/container_apps:chromexserv
sudo docker run roshandoker/container_apps:teamsxserv
sudo docker start zoomxserv
sudo docker start chromexserv
sudo docker start teamsxserv


#enable this for localhost case especially VM, Disable this on local host machine
#export DISPLAY=":1"

export DISPLAY=$DISPLAY

