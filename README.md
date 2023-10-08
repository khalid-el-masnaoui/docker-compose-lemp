# Docker Compose LEMP Stack

This repository contains a complete docker-compose configuration to start a LEMP (Linux, Nginx, Mysql, PHP) stack. mapping the container user UID with the host UID to make shared files (via volumes) accessibles.

## Details :clipboard:
The following versions are used.

- PHP 8.2 (FPM)
- Nginx 1.25.2 (latest-tag)
- MariaDB 8.0.34

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

You can also set the following environment variables, for example in the included **_.env_** file:

| Key | Description |
|-----|-------------|
|APP_NAME|The name used when creating a container.|
|MYSQL_ROOT_PASSWORD|The MySQL root password used when creating the container.|
|MYSQL_DATABASE|The MySQL database used when creating the container.|
