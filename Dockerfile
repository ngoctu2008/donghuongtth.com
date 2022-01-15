FROM registry.gitlab.com/gkc_team/devops-groups/gkc-docker-image-php

# Copy upload.ini to config

# Set working directory
WORKDIR /home/chonhagiau/ch-nha-giau/

# Add user for laravel application
RUN groupadd -g chonhagiau src
RUN useradd -u chonhagiau -ms /bin/bash -g src src

# Copy existing application directory contents

# Copy existing application directory permissions

RUN composer install
RUN composer dump-autoload

RUN chown -R chongagiau:chonhagiau /home/chonhagiau/ch-nha-giau/
# Change current user to www
USER chonhagiau


# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
