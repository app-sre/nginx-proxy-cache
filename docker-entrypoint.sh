#!/bin/bash

if [[ -z "$PROXY_DESTINATION" ]]; then echo "Variable PROXY_DESTINATION not set. Aborting."; exit 1; fi
if [[ -z "$PROXY_CACHE_VALID" ]]; then echo "Variable PROXY_CACHE_VALID not set. Aborting."; exit 1; fi

# # Add trailing slash
PROXY_DESTINATION=${PROXY_DESTINATION%/} # Strip trailing slash if any
PROXY_DESTINATION="$PROXY_DESTINATION/"  # Add trailing slash

NAMESERVER=$(grep nameserver /etc/resolv.conf | head -n 1 | cut -d " " -f 2)

echo "Configuring proxy to cache all traffic to $PROXY_DESTINATION"
/bin/cp -fv /nginx.conf.template /tmp/nginx.conf
sed -e "s@PROXY_DESTINATION@$PROXY_DESTINATION@g" -i /tmp/nginx.conf
sed -e "s@PROXY_CACHE_VALID@$PROXY_CACHE_VALID@g" -i /tmp/nginx.conf
sed -e "s/NAMESERVER/$NAMESERVER/" -i /tmp/nginx.conf

exec "$@"
