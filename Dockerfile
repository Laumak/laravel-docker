# Perus
FROM ubuntu:xenial
MAINTAINER lauri@mits.fi

# Asennetaan tarvittavat paketit
RUN apt update && \
    apt -y install git curl php php7.0 php7.0-mysql php7.0-mcrypt php7.0-json && \
    apt-get clean

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
