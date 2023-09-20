FROM debian:buster

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y php7.3 php-fpm php-mysql mariadb-client mariadb-server

RUN mkdir -p /run/php

RUN apt install wget -y && apt-get clean -y

RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
        && chmod +x wp-cli.phar \
        && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html
RUN chown -R root:root /var/www/html

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
RUN chmod 755 /etc/php/7.3/fpm/pool.d/www.conf

COPY ./tools/config.sh /etc/wordpress/config.sh
RUN chmod 777 /etc/wordpress/config.sh

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT ["/bin/bash", "/etc/wordpress/config.sh"]