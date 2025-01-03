#!/bin/bash

# Menjalankan Xvfb untuk virtual display
Xvfb :0 -screen 0 1024x768x16 &

# Menjalankan desktop XFCE4
startxfce4 &

# Menjalankan VNC server
x11vnc -display :0 -rfbport 5900 -usepw -forever &

# Menjalankan Playit untuk tunneling
/playit
