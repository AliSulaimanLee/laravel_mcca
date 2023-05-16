FROM php:8.1-cli-alpine
#environment table
ENV \
    APP_DIR="/app" \
    APP_PORT="8001"
#memindahkan file/folder ke direktori yg diinginkan
COPY . $APP_DIR
COPY .env.example $APP_DIR/.env

RUN apk add --update \
    curl \
    php \
    php-opcache \
    php-openssl \
    php-pdo \
    php-json \
    php-phar \
    php-dom \
    && rm -rf /var/cache/apk/*

RUN curl -ss https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin --filename=composer

RUN cd $APP_DIR && composer update
RUN cd $APP_DIR && php artisan key:generate

WORKDIR $APP_DIR

CMD php artisan serve --host=0.0.0.0 --port=$APP_PORT

EXPOSE $APP_PORT
