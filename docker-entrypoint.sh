#!/bin/bash

if [[ -z "$PROXY_DESTINATION" ]]; then echo "Variable PROXY_DESTINATION not set. Aborting."; exit 1; fi
if [[ -z "$PROXY_CACHE_VALID" ]]; then echo "Variable PROXY_CACHE_VALID not set. Aborting."; exit 1; fi

# # Add trailing slash
REDIRECTOR_DESTINATION=${REDIRECTOR_DESTINATION%/} # Strip trailing slash if any
REDIRECTOR_DESTINATION="$REDIRECTOR_DESTINATION/"  # Add trailing slash

echo "Configuring redirector to redirect all traffic to $REDIRECTOR_DESTINATION"
/bin/cp -fv /nginx.conf.template /tmp/nginx.conf
sed -e "s@REDIRECTOR_DESTINATION@$REDIRECTOR_DESTINATION@g" -i /tmp/nginx.conf
sed -e "s@PROXY_CACHE_VALID@$PROXY_CACHE_VALID@g" -i /tmp/nginx.conf

exec "$@"
