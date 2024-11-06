FROM ubuntu:latest
RUN apt install -y apache2 \
zip \
unzip
ADD https://github.com/nyrahul/wisecow.git /var/www/html/
WORKDIR /var/www/html/
RUN wisecow.sh
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80