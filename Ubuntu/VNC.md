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
First, we need to tell the VNC server what commands to perform upon startup. These commands are stored in a config file: `xstartup` of `.vnc` in your home directory. The script was created when you ran the `vncserver` command. Since we want VNC to work properly, we need to edit the script.

When you first set up VNC, it launches a default server instance on port `5901` This is what you would call a display port, and is referred to by VNC as `:1`. VNC can launch multiple instances on other display ports, like `:2`, `:3`, etc. When working with VNC servers, remember that `:X` is a display port that refers to `5900+X.`

Because we are going to change the configuration of the VNC server, we'll need to stop the VNC server instance that is running on port 5901. To do this, we will use the following command:
```
$ vncserver -kill :1
```
The output should look like this, with a different PID:
```
Killing Xtightvnc process ID 17648
```
Before we begin configuring the new `xstartup` file, let's back up the original just in case something goes wrong using the command below:
```
$ mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
```
Now create a new `xstartup` file using `nano` or a text editor.
```
$ nano ~/.vnc/xstartup
```
Paste these commands into the file so that they are performed automatically whenever you start or restart the VNC server, then save and close the file.
```
#!/bin/sh

# Provide a normal GUI
unset SESSION_MANAGER
exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
mate-session &
mate-panel &
```
To Close the file:
```
Control + X
```
To Save the file:
``` 
y: yes we want to save changes
```



