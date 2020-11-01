FROM debian:buster
RUN echo 'debconf debconf/frontend select teletype' | debconf-set-selections \
	&& apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y --no-install-recommends \
    	systemd \
        systemd-sysv \
        cron \
        anacron \
	&& apt-get clean \
	&& rm -rf \
    	/var/lib/apt/lists/* \
    	/var/log/alternatives.log \
    	/var/log/apt/history.log \
    	/var/log/apt/term.log \
    	/var/log/dpkg.log \
    	&& systemctl mask -- \
    	dev-hugepages.mount \
    	sys-fs-fuse-connections.mount \
	&& rm -f \
    	/etc/machine-id \
    	/var/lib/dbus/machine-id
    	
FROM debian:buster
COPY --from=0 / /
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); 
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" ]
CMD [ "/usr/sbin/init" ]
#CMD [ "/sbin/init" ]