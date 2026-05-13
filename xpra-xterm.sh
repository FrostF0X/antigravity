#!/bin/bash
runuser user -c -l "xpra start --bind-tcp=0.0.0.0:80 --min-port=80 --html=on --systemd-run=yes --daemon=no --dbus-launch= --dbus-control=no --start-child-after-connect=xterm"
