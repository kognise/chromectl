FROM ubuntu:18.04

# If squid-deb-proxy is installed, cache apt packages
RUN route -n | awk '/^0.0.0.0/ {print $2}' > /tmp/host_ip.txt
RUN echo "HEAD /" | nc `cat /tmp/host_ip.txt` 8000 | grep squid-deb-proxy \
  && (echo "Acquire::http::Proxy \"http://$(cat /tmp/host_ip.txt):8000\";" > /etc/apt/apt.conf.d/30proxy) \
  && (echo "Acquire::http::Proxy::ppa.launchpad.net DIRECT;" >> /etc/apt/apt.conf.d/30proxy) \
  || echo "No squid-deb-proxy detected on docker host"

ENV VNC_PORT 7635
ENV CHROMECTL_PORT 3124
ENV VNC_SCREEN_SIZE 1920x1080
ENV DEBIAN_FRONTEND=noninteractive

EXPOSE $VNC_PORT $CHROMECTL_PORT

ADD ./slash/ /
RUN /bin/bash /install.sh

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]