FROM ubuntu:18.04

ENV VNC_PORT 7635
ENV CHROMECTL_PORT 3124
ENV VNC_SCREEN_SIZE 1920x1080

EXPOSE $VNC_PORT $CHROMECTL_PORT

ADD ./slash/ /
RUN /bin/bash /install.sh

ENTRYPOINT [ "/bin/bash", "/entrypoint.sh" ]
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]