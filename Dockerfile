# 使用 Docker Hub 上的官方 PHP 8.0 FPM 镜像作为基础镜像
FROM php:8.0-fpm

# 安装 Nginx 和 PHP 扩展
RUN apt-get update && apt-get install -y \
    nginx \
    zlib1g-dev \
    libzip-dev \
    libonig-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install pdo_mysql mbstring zip gd

# 添加 Nginx 配置文件
COPY nginx.conf /etc/nginx/nginx.conf

# 设置容器中的工作目录为 /var/www/html
WORKDIR /var/www/html

# 将当前目录的内容复制到容器的 /var/www/html 目录
COPY . /var/www/html

# 开放容器的 80 端口，使其可以从容器外部访问
EXPOSE 80

# 定义环境变量
ENV NAME World

# 启动 Nginx 和 PHP-FPM
CMD php-fpm -D & nginx -g 'daemon off;'