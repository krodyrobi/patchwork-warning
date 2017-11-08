FROM php:5.6-cli

MAINTAINER Krody Robert <robi@presslabs.com>

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer

# PHP extension
RUN requirements="zlib1g-dev libicu-dev git curl" \
    && apt-get update && apt-get install -y $requirements && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install intl \
    && docker-php-ext-install zip \
    && apt-get purge --auto-remove -y

ADD docker/php.ini /usr/local/etc/php/php.ini

# Add the application
ADD . /app
WORKDIR /app

RUN composer install -o

# Ensure that the production container will run with the www-data user
RUN chown www-data /app

ENTRYPOINT ["make", "test"]