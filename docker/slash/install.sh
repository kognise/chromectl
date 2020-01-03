#!/usr/bin/env bash
set -e

echo '--------------------- UPDATING APT CACHE ---------------------'
apt-get update
echo '--------------------- INSTALLING USER TOOLS ---------------------'
apt-get install -y chromium-browser pulseaudio
echo '--------------------- INSTALLING SUPERVISOR ---------------------'
apt-get install -y supervisor
echo '--------------------- INSTALLING DESKTOP SYSTEMS ---------------------'
apt-get install -y x11vnc fluxbox
apt-get clean -y

rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/*
useradd -m -G pulse-access chrome 
usermod -s /bin/bash chrome
ln -s /update /usr/local/sbin/update

mkdir -p /home/chrome/.fluxbox
echo '\
  session.screen0.toolbar.visible:  false\n\
  session.screen0.fullMaximization: true\n\
  session.screen0.maxDisableResize: true\n\
  session.screen0.maxDisableMove:   true\n\
  session.screen0.defaultDeco:      NONE\n\
' >> /home/chrome/.fluxbox/init