#!/usr/bin/env bash
set -e

apt-get update
apt-get install -y chromium-browser pulseaudio supervisor x11vnc fluxbox
# apt-get clean -y

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