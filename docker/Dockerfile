FROM ubuntu:18.04

ENV VNC_PORT 7635
ENV CHROMECTL_PORT 3124
ENV VNC_SCREEN_SIZE 1920x1080
ENV DEBIAN_FRONTEND noninteractive

ARG APT_PROXY_PORT
ENV APT_PROXY_PORT=$APT_PROXY_PORT

ADD ./slash/ /
RUN /bin/bash /cache.sh
RUN /bin/bash /install.sh

EXPOSE $VNC_PORT $CHROMECTL_PORT

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]