FROM php:8.2-apache

# Install system dependencies and SQLite
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpng-dev libonig-dev libxml2-dev \
    sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite mbstring exif pcntl bcmath gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer manually
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www

# Copy the Laravel app
COPY ./src /var/www

# Set proper permissions
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# Expose Apache port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]

