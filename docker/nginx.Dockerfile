FROM nginx:latest

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

#ADD directories
RUN mkdir /etc/nginx/sites-available && mkdir /etc/nginx/sites-enabled

COPY configurations/nginx/nginx.conf /etc/nginx/nginx.conf
COPY configurations/nginx/sites-available /etc/nginx/sites-available
COPY --chown=www-data:www-data src/ /var/www/html/
 
#ADD sumbolic linlk
RUN  ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/  

EXPOSE 80/tcp
EXPOSE 443/tcp 

# drop symlinks
RUN unlink /var/log/nginx/access.log
RUN unlink /var/log/nginx/error.log

RUN chown -R www-data:www-data /var/log/nginx && \
    chown -R www-data:www-data /etc/nginx && \
    chown -R www-data:www-data /var/cache/nginx && \
    chown -R www-data:www-data /var/www && \
    install  -o www-data -g www-data /dev/null /var/run/nginx.pid
    
WORKDIR /var/www/html    

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER www-data

CMD ["/usr/sbin/nginx", "-g", "daemon off;"] 

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/var/log/nginx", "/var/www/html"]

