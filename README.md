# Docker Compose LEMP Stack

This repository contains a complete docker-compose configuration to start a LEMP (Linux, Nginx, Mysql, PHP) stack. mapping the container user UID with the host UID to make shared files (via volumes) accessibles.

## Details :clipboard:
The following versions are used.

- PHP 8.2 (FPM)
- Nginx 1.25.2 (latest-tag)
- MySql 8.0.34

## Extensions :sparkles:

The custom php image image includes all the following extensions (installed and enabled).

| Extension | README |
| ------ | ------ |
| **Redis** | [Github Repository](https://github.com/redis/redis) |
| **Memcached** | [Github Repository](https://github.com/memcached/memcached) |
| **Apcu** | [PHP Manual](https://www.php.net/manual/en/book.apcu.php) |
| **Mcrypt** | [PHP Manual](https://www.php.net/manual/en/book.mcrypt.php) |
| **Iconv** | [PHP Manual](https://www.php.net/manual/en/function.iconv.php) |
| **Mbstring** | [PHP Manual](https://www.php.net/manual/en/book.mbstring.php) |
| **Mysqli** | [PHP Manual](https://www.php.net/manual/en/book.mysqli.php) |
| **Pdo_mysql** | [PHP Manual](https://www.php.net/manual/en/ref.pdo-mysql.php) |
| **Sockets** | [PHP Manual](https://www.php.net/manual/en/book.sockets.php) |
| **Zip** | [PHP Manual](https://www.php.net/manual/en/book.zip.php) |
| **Pcntl** | [PHP Manual](https://www.php.net/manual/en/book.pcntl.php) |
| **Ftp** | [PHP Manual](https://www.php.net/manual/en/book.ftp.php) |
| **Bcmath** | [PHP Manual](https://www.php.net/manual/en/book.bc.php) |
| **Intl** | [PHP Manual](https://www.php.net/manual/en/book.intl.php) |
| **Gettext** | [PHP Manual](https://www.php.net/manual/en/function.gettext.php) |
And many others, you can discover them by yourself :eyes:

In addition of the above extension , this php-cli image includes _**Composer**_ and _**PhpUnit**_ as well, installed globally, and such as _wget_, _vim_, _git_, _unzip_ ...

## File Structure :open_file_folder:
This repository is organized following  the below file structure
```bash
├── configurations                          #Configurations folder
│   ├── mysql
│   │   └── custom.cnf
│   ├── nginx
│   │   ├── nginx.conf
│   │   └── sites-available
│   │       └── default.conf
│   └── php
│       ├── php
│       │   ├── mods-available
│       │   │   └── opcache.ini
│       │   └── php.ini
│       ├── php-fpm.conf
│       └── pool.d
│           ├── www.conf
│           └── zz-docker.conf
├── docker                                  #Docker files and database scripts
│   ├── initScripts
│   │   └── init.sql
│   ├── mysql.Dockerfile
│   ├── nginx.Dockerfile
│   └── php.Dockerfile
├── logs                                    #Services logs
│   ├── mysql
│   │   ├── error.log
│   │   └── slow.log
│   │   └── .gitignore
│   ├── nginx
│   │   ├── access.log
│   │   └── error.log
│   │   └── .gitignore
│   └── php
│   │   └── error.log
│   │   └── php-fpm.log
│   │   └── .gitignore
└── src
│   │   └── composer.json
│   │   └─ composer.lock
│   │   └── index.php
│   │   └── test_db.php
├── .env                                    #Environement variables file
├──  docker-compose.yml                     
├── .dockerignore
├── .gitignore
├──  README.md
```


## Configurations :gear:

All user services (Nginx, php, php-fpm , mysql) relay on custom configurations instead of using the default assigned configs.
the below table describe each service's configs

| Service | Custom Configuration Location |
|-----|-------------|
| NGINX |`configurations/nginx/nginx.conf` and `configurations/nginx/sites-available/default.conf`|
| PHP |`configurations/php/php/php.ini` and `configurations/php/php/mods-available/opcache.ini`|
| PHP-FPM |`configurations/php/php-fpm.conf` and `configurations/php/pool.d/www.conf` and `configurations/php/pool.d/zz-docker.conf`|
| MYSQL |`configurations/mysql/custom.cnf`|

You can also set the following environment variables, for example in the included **_.env_** file:

| Key | Description |
|-----|-------------|
|APP_NAME|The name used when creating a container.|
|MYSQL_ROOT_PASSWORD|The MySQL root password used when creating the container.|
|MYSQL_DATABASE|The MySQL database used when creating the container.|


## Docker :hammer_and_wrench:

##### Exposed and Mapped Ports
Nginx is exposig ports _80/tcp_ and _443/tcp_, while php-fpm is exposing port 9000/tcp in case of listening to tcp connection (the current behaviour is that php-fpm is listening to the **_unix socket connections_**), MySql is listening on port _3306/tcp_.

Ports mapping is specified in the _docker-compose_ file as : 
```
0.0.0.0:8080->80/tcp #Nginx 80
0.0.0.0:443->443/tcp #Nginx 443
0.0.0.0:9000->9000/tcp #php-fpm 9000
0.0.0.0:3306->3306/tcp #mysql 3306
```
Change the above mappings as per your need.

##### UID and GID Mappings
We are mapping the container user UID and groub GID with the host UID/GID to make shared files (via volumes) accessibles.
The _docker-compose_ file is using two environment variables to map the UID and GID as below:

```bash
UID: ${XUID} #UID is a read-only variable in bash (reserved variable- hence the namig XUID)
GID: ${XGID}
```

Before you build and run the project, make sure to map the correct values by settting the two environment variable (_XUID_ and _XGID_). There are many ways to do so (put the variables in the build command itself, Variable export..), but we recommand to store the variables in the config so they can be permannent using:
```bash
# To your ~/.bashrc file append these two lines:
$ export XUID=$(id -u) 
$ export XGID=$(id -g)

#Then refresh the file (or open a new terminal):
$ source ~/.bashrc # or '. ~/.bashrc'
```

##### Networking
The lemp containers are sharing the same network under docker-compsoe called _custom-network_

#####  Installation  :electric_plug:
Clone this repository and follow the simple steps:
```bash
# clone
$ git clone git@github.com:khalid-el-masnaoui/docker-compose-lemp.git

#cd into the working diretcory
$ cd docker-compose-lemp

#build and start the services
$ docker-compose up -d --build

#accessing the services containers
$ docker exec -it {service-name} /bin/bash
```

This will create the custom lemp stack containers pull-in/install the necessary dependencies.

Verify the deployment by navigating to your server address in your preferred browser.


```sh
localhost:8080 # should display phpinfo page -> verify all extensions enabled such as opcache , jit , apcu , redis ...
localhost:8080/test_db.php # verify the connection to mysql database is working correctly and retrive some data from the database
```

