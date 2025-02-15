#!/bin/sh

if [ -z "$WEBDAV_USERNAME" ] || [ -z "$WEBDAV_PASSWORD" ]; then
  echo "Error: WEBDAV_USERNAME and WEBDAV_PASSWORD must be set."
  exit 1
fi

WEBDAV_UID=${WEBDAV_UID:-1000}
WEBDAV_GID=${WEBDAV_GID:-1000}
WEBDAV_MAX_BODY_SIZE=${WEBDAV_MAX_BODY_SIZE:-1G}
WEBDAV_TIMEOUT=${WEBDAV_TIMEOUT:-600s}

addgroup -g "$WEBDAV_GID" webdavgroup
adduser -D -u "$WEBDAV_UID" -G webdavgroup webdavuser

chown -R "$WEBDAV_UID":"$WEBDAV_GID" /var/www/webdav

echo "$WEBDAV_PASSWORD" | htpasswd -c -i /etc/nginx/htpasswd "$WEBDAV_USERNAME"

envsubst '$WEBDAV_MAX_BODY_SIZE $WEBDAV_TIMEOUT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

exec nginx -g "daemon off;"
