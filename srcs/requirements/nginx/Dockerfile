FROM debian:buster

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install nginx -y

RUN apt-get install openssl -y
RUN mkdir -p /etc/nginx/ssl \
    && openssl req\
    -new\
    -nodes\
    -x509\
    -newkey rsa:2048\
    -out etc/nginx/ssl/inception.crt\
    -keyout etc/nginx/ssl/inception.key\
    -subj "/C=FR/ST=IDF/L=PARIS/O=42School/CN=hcherpre.42.fr/UID=hcherpre"

RUN mkdir -p /var/www/html
RUN chmod 755 /etc/nginx/ssl

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;" ]