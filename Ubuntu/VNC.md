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
To ensure that the VNC server will be able to use this new startup file properly, we'll need to grant executable privileges to it.
```
$ sudo chmod +x ~/.vnc/xstartup
```
Now, restart the VNC server.
```
$ vncserver
```
The server should be started with an output similar to this:
```
New 'X' desktop is your_server_name.com:1

Starting applications specified in /home/sammy/.vnc/xstartup
Log file is /home/sammy/.vnc/liniverse.com:1.log
```
## Step 3: Testing the VNC Desktop
In this step, we'll test the connectivity of your VNC server.
First, we need to create an SSH connection on your local computer that securely forwards to the `localhost` connection for VNC. You can do this via the terminal on Linux or OS X with following command. Remember to replace `user` and `server_ip_address` with the sudo non-root username and IP address of your server.
```
$ ssh -L 5901:127.0.0.1:5901 -N -f -l username server_ip_address
```
If you are using a graphical SSH client, like PuTTY, use `server_ip_address` as the connection IP, and set `localhost:5901` as a new forwarded port in the program's SSH tunnel settings.

Next, you may now use a VNC client to attempt a connection to the VNC server at `localhost:5901`. You'll be prompted to authenticate. The correct password to use is the one you set in Step 1.

Once you are connected, you should see something like this
# Screensot HERE

## Step 4: Creating a VNC Service File
Next, we'll set up the VNC server as a systemd service. This will make it possible to start, stop, and restart it as needed, like any other systemd service.

First, create a new unit file called `/etc/systemd/system/vncserver@.service` using a text editor:
```
$ sudo nano /etc/systemd/system/vncserver@.service
```
Copy and paste the following into it. Be sure to change the value of **User** and the username in the value of **PIDFILE** to match your username.
```
[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=sammy
PAMName=login
PIDFile=/home/sammy/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1280x800 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
```
Save and close the file.

Next, make the system aware of the new unit file.
```
$ sudo systemctl daemon-reload
```

Enable the unit file.
```
$ sudo systemctl enable vncserver@1.service
```

The `1` following the `@` sign signifies which display number the service should appear over, in this case the default `:1` as was discussed above. 
Stop the current instance of the VNC server if it's still running.
```
$ vncserver -kill :1
```

