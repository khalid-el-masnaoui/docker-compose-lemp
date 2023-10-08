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
├── configurations                        
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
├── docker                               
│   ├── initScripts
│   │   └── init.sql
│   ├── mysql.Dockerfile
│   ├── nginx.Dockerfile
│   └── php.Dockerfile
├── logs
│   ├── mysql
│   │   ├── error.log
│   │   └── slow.log
│   │   └── .gitignore
│   ├── nginx
│   │   ├── access.log
│   │   └── error.log
│   │   └── .gitignore
│   └── php
│       ├── error.log
│       └── php-fpm.log
│   │   └── .gitignore
└── src
│       ├── composer.json
│       ├── composer.lock
│       ├── index.php
│       ├── test_db.php
├── .env
├── docker-compose.yml
├── .dockerignore
├── .gitignore
├── README.md
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

