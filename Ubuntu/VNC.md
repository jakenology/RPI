# Setting up VNC on Ubuntu Mate
## Step 1: Installing the Desktop Environment and VNC Server
### First, let's install Xfce and TightVNC using the commands below:
```
$ sudo apt-get update
$ sudo apt-get install xfce4 xfce4-goodies tightvncserver
```
### Second, configure VNC with initial settings using the command below:
```
$ vncserver
```
##### You will then be prompted to enter and verify a password, as well as a view-only password.

## Step 2: Configuring the VNC Server
##### First, we need to tell our VNC server what commands to perform when it starts up. These commands are located in a configuration file called xstartup in the .vnc folder under your home directory. The startup script was created when you ran the vncserver in the previous step, but we need modify some of the commands for the Xfce desktop.

##### When you first set up VNC, it launches a default server instance on port **5901** This is what you would call a display port, and is referred to by VNC as ```:1```. VNC can launch multiple instances on other display ports, like ```:2```, ```:3```, etc. When working with VNC servers, remember that :X is a display port that refers to 5900+X.
