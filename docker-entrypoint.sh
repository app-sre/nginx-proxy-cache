#!/bin/bash

COUNT=0
for VAR in PROXY_DESTINATION \
           PROXY_CACHE_VALID \
           CACHE_MAX_SIZE
do
    if [[ ! "${!VAR}" ]]; then
        echo "Variable $VAR not set. Aborting."
        COUNT=$((COUNT + 1))
    fi
done

[[ $COUNT -gt 0 ]] && exit 1

# # Add trailing slash
PROXY_DESTINATION=${PROXY_DESTINATION%/} # Strip trailing slash if any
PROXY_DESTINATION="$PROXY_DESTINATION/"  # Add trailing slash

NAMESERVER=$(grep nameserver /etc/resolv.conf | head -n 1 | cut -d " " -f 2)

echo "Configuring proxy to cache all traffic to $PROXY_DESTINATION"
/bin/cp -fv /nginx.conf.template /tmp/nginx.conf
sed -e "s@PROXY_DESTINATION@$PROXY_DESTINATION@g" -i /tmp/nginx.conf
sed -e "s@PROXY_CACHE_VALID@$PROXY_CACHE_VALID@g" -i /tmp/nginx.conf
sed -e "s@CACHE_MAX_SIZE@$CACHE_MAX_SIZE@g" -i /tmp/nginx.conf
sed -e "s@NAMESERVER@$NAMESERVER@g" -i /tmp/nginx.conf

exec "$@"
