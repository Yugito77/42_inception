FROM debian:buster

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install mariadb-server -y \
    && apt-get install mariadb-client -y 

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf
COPY ./tools/database.sh /etc/mysql/database.sh

RUN chmod -R 777 /etc/mysql/database.sh
RUN chmod -R 755 /etc/mysql/mariadb.conf.d/mariadb.cnf

EXPOSE 3306

CMD [ "/bin/bash", "/etc/mysql/database.sh" ]