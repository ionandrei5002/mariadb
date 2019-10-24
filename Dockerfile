FROM ubuntu:16.04

# ARGS
ARG userid
ARG groupid
ARG username

# VARS
ENV PHP_VERSION "7.1"

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

# DBUS
RUN apt install -y \
        dbus-x11

# APACHE
RUN apt update && \
    apt install -y \
        apache2

# MYSQL
RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN apt install -y --no-install-recommends mariadb-server mariadb-client

RUN find /etc/mysql/ -name '*.cnf' -print0 \
        | xargs -0 grep -lZE '^(bind-address|log)' \
        | xargs -rt -0 sed -Ei 's/^(bind-address|log)/#&/'

# PHP
RUN add-apt-repository -y ppa:ondrej/php \
        && apt-get update \
        && apt-get install -y \
        libapache2-mod-php${PHP_VERSION} \
        php${PHP_VERSION} \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-sqlite3 \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-zip

# PHPMYADMIN
RUN apt install -y \
        phpmyadmin

# CLEANUP
RUN apt clean -y \
        && apt autoclean -y \
        && apt autoremove -y

# CONFIG APACHE
RUN sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php/${PHP_VERSION}/apache2/php.ini \
        && sed -ri 's/^display_errors\s*=\s*Off/display_errors = On/g' /etc/php/${PHP_VERSION}/cli/php.ini
RUN a2enmod rewrite

# PHPMYADMIN
RUN ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf \
        && ln -s /etc/apache2/conf-available/phpmyadmin.conf /etc/apache2/conf-enabled/phpmyadmin.conf

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

# PORTS
EXPOSE 80
EXPOSE 8000
EXPOSE 3306

COPY init.sh /home/$username/init.sh
COPY music.sql /home/$username/music.sql

CMD [ "/bin/bash" ]

ENTRYPOINT bash init.sh