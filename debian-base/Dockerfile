FROM debian:buster

COPY setup/ /usr/local/debian-base-setup/
COPY files/syslog.conf /etc/syslog.conf.stdout
COPY scripts /usr/local/bin
RUN sh -c /usr/local/debian-base-setup/010-debian-base-minimal
RUN sh -c /usr/local/debian-base-setup/020-debian-base-standard
COPY preinit /usr/local/preinit

CMD ["/usr/local/bin/boot-debian-base"]

