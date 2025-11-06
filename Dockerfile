# Base image
FROM php:8.4
# Defined working directory
WORKDIR /project
# Copy laravel project in /project directory
COPY app .

# Install php extentions and composer
RUN apt update && apt install -y libfreetype-dev \
 	libjpeg62-turbo-dev \
 	libpng-dev \
	libpq-dev \
	zip \
	&& php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& mv composer.phar /usr/local/bin/composer \
	&& docker-php-ext-install pdo pgsql pdo_pgsql \
        && composer install


# RUN
EXPOSE 8000

RUN adduser www \
    && usermod -aG www www

# Generate key and install dependances
RUN chmod u+x /project/entrypoint.sh \
   && composer i \
   && php artisan key:gen

RUN chown -R www:www /project \
   && chmod -R 775 /project/storage

USER www

# Start main proccess
ENTRYPOINT ["sleep", "10000000000000000000000000000000000000"]
#ENTRYPOINT ["php", "artisan", "serve", "--host", "0.0.0.0"]


