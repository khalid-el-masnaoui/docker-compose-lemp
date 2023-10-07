FROM php:8.2-fpm

SHELL ["/bin/bash", "-c"]

RUN chmod 1777 /tmp
RUN  apt-get update -y && apt-get install -y procps 
 
#add user and group
RUN groupadd -f www-data && \
    (id -u www-data &> /dev/null || useradd -G www-data www-data -D)

#assign the created user same UID AND GUID OF the host for the mounted dir owner
ARG UID
ARG GID
 
RUN usermod -u $UID www-data
RUN groupmod -g $GID www-data

EXPOSE 9000

# PID directory
RUN install -d -m 0755 -o www-data -g www-data /run/php-fpm

#custom fpm configs
COPY ./configurations/php/ /usr/local/etc/

#fpm logs
RUN install -d -o www-data -g www-data /var/log/php && \
    install -o www-data -g www-data /dev/null /var/log/php/php-fpm.log


#clean dirs
RUN  apt-get clean && \
    rm -rf var/lib/apt/lists/* /tmp/* /var/tmp/*

USER www-data
