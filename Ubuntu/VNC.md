# Setting up VNC on Ubuntu Mate
## Step 1: Installing the Desktop Environment and VNC Server
### First, let's install Xfce and TightVNC using the commands below. 
```
$ sudo apt-get update
$ sudo apt-get install xfce4 xfce4-goodies tightvncserver
```
### Second, configure VNC with initial settings using the command below.
```
$ vncserver
```
#### You will be prompted to enter and verify a password, as well as a view-only password.
