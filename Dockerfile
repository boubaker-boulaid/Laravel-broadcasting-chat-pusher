# use php 8.2 fmp-alpine (super light) as base image
FROM php:8.3-fpm-alpine

# install system dependencies and nodejs npm 
RUN apk add --no-cache \
    libpng-dev\
    libzip-dev \
    sqlite-dev \
    zip \
    unzip \
    nodejs \
    npm

# install php extensions for laravel and sqlite
RUN docker-php-ext-install pdo_mysql pdo_sqlite bcmath gd zip

# get the composer
COPY  --from=composer:latest /usr/bin/composer /usr/bin/composer

# set the working directory
WORKDIR /simple-chat-app

# copy the files that contains all the dependencies and libraries the app need and install them
COPY composer.json composer.lock ./
RUN composer install --no-scripts --no-autoloader

# copy the files that contains all the dependencies and libraries the app need and install them
COPY package*.json ./
RUN npm install

# copy everything to the container
COPY . .

RUN npm run build

# Set permissions so Laravel can write to the SQLite file
RUN chown -R www-data:www-data /simple-chat-app/storage /simple-chat-app/bootstrap/cache /simple-chat-app/database

# start the laravel built-in server
CMD [ "php", "artisan", "serve", "--host=0.0.0.0"]
