
Here explaination is done with respect to zoom app, but all other container follow same method to execute.

1. start with ./run_zoom_container.sh script which will create the respective container and then once completes logs in to the container.

2. once logged in to container then just run the respective apps by typing like below commands

teams 

zoom

google-chrome

3. below command can be used to log in to container or start the container

sudo docker run -it --entrypoint /bin/bash local/zoomxserv:0.0.1

then type 
zoom

To launch the zoom app.

4. to connect to existing container need to use below command

sudo docker exec -it zoomxserv /bin/bash

then in the terminal type 
zoom 
To launch app.

To view all the docker containers

sudo docker ps -a

To Delete specific container

sudo docker rm -f zoomxserv

To Remove all the docker containers use below command

sudo docker system prune -a

or 

sudo docker rm -f $(sudo docker ps -aq)



Troubleshoot: 

If there is issue in launching the app then DISPLAY environment value might be Null or invalid.
So either close the terminal and then launch new one and then zoom or any other app to launch. 

Most of the launching issues are there because of Invalid DISPLAY value for the environment variable.

--------------------------------------------------------------------------------------------------

1. Xserver Side setup on ubuntu platform:
--------------------------------------------
Copy the server side files to a folder and assign them execute permission with below command.
below is the files needed for server side container.
docker-teams-xserv
    dockerfile
    run_teams_container.sh 

cd docker-teams-xserv
chmod -R 777 *

Right now whenever we are connecting to ubuntu server we are starting the container and redirecting the browser app via ssh to client. 
So best way to achieve this we can configure above scripts to run whenever client connects to the ubuntu server. So we need to do below changes to make this happen. 

put these two files.

run_teams_container.sh
dockerfile

in the /etc/profile.d/

with execute permission. so whenever client connection connects then docker container is started. (This is workaround solution when we don't want to execute commands to run the container script from client side .bat file) 

and also update the ipaddress in the 
run_teams_container.sh file on this statement

export DISPLAY = 10.0.0.5:10.0

replace this entry with correct client side ipaddress so that linux apps are redirected to specific client.

and 10.0 is the desktop number which will be configured in the xming app on the client side in the windows machine.

Now with this configuration whenever user connects to this ubuntu server with ssh, docker container with browser is started and display is redirected to above mentioned ipaddress. so if you are seeing multiple browser session popped up on the client side then reason will be due to this profile based script execution.

Since this is ssh based redirection client side need to be configured first before executing server side script. Otherwise we get standard error cannot be connected to X display.

If we don't want script need to be executed on each ssh connection then we are free to configure as per your need.


2. client side windows configuration:
----------------------------------------- 

Files needed on the client side.
DockerXstart.bat

softwares need to be installed on the windows 10 machine.
xming for rendering the GUI
https://sourceforge.net/projects/xming/
 
Putty for doing X11 forwarding connection 
https://www.putty.org/



If we are using DockerXstart.bat file on the client side windows machine for connection then right now that bat file doesn't run any linux commands. So we can run all the coSo we need to execute the above script on each connection, 

it is designed to automatically launch the script whenever user connects so current azure machine is configured like that (52.249.178.57)

If the x11 instance need to be started whenever client connects then put these two files.

run_teams_container.sh
dockerfile

in the /etc/profile.d/

with execute permission. so whenever client connection connects then docker container is started. (This is workaround solution when we don't want to execute commands to run the container script from client side .bat file) 

and also specify the client ipaddress in the 
run_teams_container.sh file on this statement

export DISPLAY = 10.0.0.5:10.0

replace this entry with correct client side ipaddress so that linux apps are redirected to specific client.

and put the 
DockerXstart.bat 

on the client side if it is windows client.
and also install putty client on the windows machine.
along with xming server to create the x11 client on windows.
https://sourceforge.net/projects/xming/
 
https://www.putty.org/

right now script on the server hardcoded to desktop number 10, so when launch xming server specify the virtual desktop to be created with number 10.
follow the procedure mentioned here to launch putty and configure xming client.

https://www.youtube.com/watch?v=YLAYfwUPj7s

or
 
https://www.youtube.com/watch?v=QRsma2vkEQE

when we complete the setup we can launch any of the linux apps on the windows and they run from xming window. 
if we want to run other apps then just in the ssh terminal of the server just type the application name. eg

gedit &

calc &

right now setup is configured on this machine on azure setup.

linux server with docker container
------------------------------
52.249.178.57

demo
password321#

scripts avilable in this path for each login

/etc/profile.d/

and main script

/home/demo/roshan/Container/AltOS/Scripts/docker-teams-xserv


windows 10 current ip
---------------------
52.188.162.255

demo
password321#


All the setup configuration and script files are available in this path.

https://git.cpgswtools.com/projects/CCSW/repos/roshan/browse/Container/AltOS/Scripts/docker-teams-xserv

and running the run_teams_container.sh file will start the complete flow of the container and then launches the browser locally.

