FROM debian:buster

COPY setup/ /usr/local/debian-base-setup/
COPY files/ /usr/local/debian-base-setup/files/
COPY scripts /usr/local/bin
RUN sh -c /usr/local/debian-base-setup/010-debian-base-minimal
RUN sh -c /usr/local/debian-base-setup/020-debian-base-standard
COPY preinit /usr/local/preinit

CMD ["/usr/local/bin/boot-debian-base"]

