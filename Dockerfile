FROM nginx:alpine

RUN apk add --no-cache nginx-mod-http-dav-ext apache2-utils gettext

COPY nginx.conf.template /etc/nginx/nginx.conf.template

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir -p /var/www/webdav

ENTRYPOINT ["/entrypoint.sh"]