FROM php:8.0-fpm

# Set the working directory in the container to /var/www/html
WORKDIR /var/www/html

# Install any needed PHP extensions
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    libonig-dev \
  && docker-php-ext-install pdo_mysql mbstring zip

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["php", "index.php"]
