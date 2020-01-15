FROM ubuntu:16.04

# ARGS
ARG userid
ARG groupid
ARG username

# SET NONINTERACTIVE
ENV DEBIAN_FRONTEND "noninteractive"

# RUN STUFF AS ROOT
USER root

# UPDATE
RUN apt update

# LOCALE
RUN apt install -y \
        locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
 && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US
ENV LC_ALL en_US.UTF-8

# BASICS
RUN apt install -y \
        apt-transport-https \
        apt-utils \
        htop \
        aptitude \
        nano \
        screen \
        software-properties-common \
        sudo \
        wget \
        net-tools

# MYSQL
RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN apt install -y --no-install-recommends mariadb-server mariadb-client

RUN find /etc/mysql/ -name '*.cnf' -print0 \
        | xargs -0 grep -lZE '^(bind-address|log)' \
        | xargs -rt -0 sed -Ei 's/^(bind-address|log)/#&/'

# CONFIG MYSQL
VOLUME /var/lib/mysql/

RUN apt clean && \
        rm -rf /var/lib/apt/lists/* && \
        rm -rf /tmp/*

RUN mkdir -p /home/$username \
        && echo "$username:x:$userid:$groupid:$username,,,:/home/$username:/bin/bash" >> /etc/passwd \
        && echo "$username:x:$userid:" >> /etc/group \
        && mkdir -p /etc/sudoers.d \
        && echo "$username ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$username \
        && chmod 0440 /etc/sudoers.d/$username \
        && chown $userid:$groupid -R /home/$username \
        && chmod 777 -R /home/$username \
        && usermod -a -G $username www-data \
	&& dbus-uuidgen > /var/lib/dbus/machine-id

# UNSET NONINTERACTIVE
ENV DEBIAN_FRONTEND ""

USER $username
ENV SHELL /bin/bash
ENV HOME /home/$username
WORKDIR /home/$username

EXPOSE 3306

COPY init.sh /home/$username/init.sh
COPY music.sql /home/$username/music.sql
COPY latest_data.sql /home/$username/latest_data.sql

CMD [ "/bin/bash" ]

ENTRYPOINT bash init.sh