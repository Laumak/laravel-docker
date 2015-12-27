# Perus
FROM ubuntu:trusty
MAINTAINER latemak@gmail.com

# Lisätään tarvittavat ppa:t
RUN apt-get update && \
	apt-get -y install software-properties-common && \
	add-apt-repository -y ppa:ondrej/php-7.0 && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C

# Asennetaan tarvittavat paketit
RUN apt-get update && \
    apt-get -y install git curl php7.0 php7.0-mysql php7.0-json && \
    apt-get clean && \
    rm -rf /var/www/html

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# Asetetaan working directory Composeria varten
WORKDIR /var/www

# Asennetaan Composer & Laravel
RUN curl -sS https://getcomposer.org/installer | php && \
	mv composer.phar /usr/local/bin/composer

EXPOSE 80
EXPOSE 443

# Käynnistetään Apache2 automaattisesti
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
