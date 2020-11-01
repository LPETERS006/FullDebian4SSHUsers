FROM debian:buster AS pre
RUN echo 'debconf debconf/frontend select teletype' | debconf-set-selections \
	&& apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y -f -m --no-install-recommends \
    	systemd \
        systemd-sysv \
        cron \
        anacron \
        apt-utils \
        apache2 \
        curl \
        unzip \
        sudo \
        net-tools \
        ssh \
        git \
        wget \
        dirmngr \
        tmux \
        openssh-server \
        apt-transport-https \
        gnupg2 \
        software-properties-common \
        open-vm-tools \        
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
    	
FROM debian:buster AS base
COPY --from=pre / /
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); 
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" ]
CMD [ "/usr/sbin/init" ]
#CMD [ "/sbin/init" ]

FROM base
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
	&& chmod +x get-docker.sh \
	&& ./get-docker.sh \
	&& curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
	&& chmod +x /usr/local/bin/docker-compose \
	&& (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); 
COPY ./bcr /usr/local/bin	
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" ]
CMD [ "/usr/sbin/init" ]
#CMD [ "/sbin/init" ]
		
	
