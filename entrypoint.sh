#!/bin/sh

if [ -z "$WEBDAV_USERNAME" ] || [ -z "$WEBDAV_PASSWORD" ]; then
  echo "Error: WEBDAV_USERNAME and WEBDAV_PASSWORD must be set."
  exit 1
fi

WEBDAV_UID=${WEBDAV_UID:-1000}
WEBDAV_GID=${WEBDAV_GID:-1000}

addgroup -g "$WEBDAV_GID" webdavgroup
adduser -D -u "$WEBDAV_UID" -G webdavgroup webdavuser

#chown -R "$WEBDAV_UID":"$WEBDAV_GID" /var/www/webdav

echo "$WEBDAV_PASSWORD" | htpasswd -c -i /etc/nginx/htpasswd "$WEBDAV_USERNAME"

exec nginx -g "daemon off;"
