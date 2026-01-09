FROM php:8.4-fpm

# Install system dependencies FIRST
RUN apt-get update && apt-get install -y \
    libonig-dev \
    pkg-config \
    zip unzip \
    && rm -rf /var/lib/apt/lists/*

# Install required PHP extensions
RUN docker-php-ext-install mbstring pdo pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# working directory
WORKDIR /var/www

# Copy existing application 
COPY . .

# Skip scripts to avoid concurrent process errors
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Run post-install scripts separately if needed
RUN composer run-script post-autoload-dump --no-interaction || true

# Copy .env file if doesn't exist
RUN if [ ! -f .env ]; then cp .env.example .env; fi

#  application key
RUN php artisan key:generate

#  proper permissions
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expose port
EXPOSE 9000

# Start PHP-FPM server
CMD ["php-fpm"]