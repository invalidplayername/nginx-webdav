FROM nginx:latest

RUN apt-get update && apt-get install -y apache2-utils gettext && rm -rf /var/lib/apt/lists/*

COPY nginx.conf.template /etc/nginx/nginx.conf.template

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /var/www/webdav

ENTRYPOINT ["/entrypoint.sh"]
