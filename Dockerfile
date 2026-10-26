FROM webdevops/php-nginx:8.2@sha256:988a780b771ce53616e1a209ab4634c29374df8d1c1d61a1a9cdba09edab14ea
# Reject a base image missing the PHP2Shell fixes; configure PHP before requests.
RUN printf '\nsession.upload_progress.enabled=0\n' >> /opt/docker/etc/php/php.ini \
    && php -r 'exit(PHP_VERSION_ID >= 80235 && PHP_VERSION_ID < 80300 && !ini_get("session.upload_progress.enabled") ? 0 : 1);'
COPY . /app
WORKDIR /app
RUN [ "sh", "-c", "composer install --ignore-platform-reqs" ]
RUN [ "sh", "-c", "chmod -R 777 /app" ]
