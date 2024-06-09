#! /bin/bash

sudo -u postgres /usr/lib/postgresql/14/bin/pg_ctl -D /opt/polarion/data/postgres-data -l /opt/polarion/data/postgres-data/log.out -o "-p 5434" start
service apache2 start

FILE="/opt/polarion/etc/polarion.properties"

OTHER_PARAMS=(
    "com.siemens.polarion.rest.enabled=true"
    "com.siemens.polarion.rest.swaggerUi.enabled=true"
    "com.siemens.polarion.rest.cors.allowedOrigins=*"
)

if [[ -n "$ALLOWED_HOSTS" ]]; then
    TomcatServiceRequestSafeListedHosts="TomcatService.request.safeListedHosts=$ALLOWED_HOSTS"
elif [[ "$#" -gt 0 ]]; then
    TomcatServiceRequestSafeListedHostsValues=$(printf "%s," "$@")
    TomcatServiceRequestSafeListedHosts="TomcatService.request.safeListedHosts=${TomcatServiceRequestSafeListedHostsValues%,}" # Removes the trailing comma
else
    echo "No values provided for TomcatService.request.safeListedHosts. Exiting"
    exit 1
fi

PARAMS=(
    "$TomcatServiceRequestSafeListedHosts"
    "${OTHER_PARAMS[@]}"
)

sed -i '/^# End property file$/d' "$FILE"

add_or_update_param() {
    local param="$1"
    local param_name=$(echo "$param" | cut -d '=' -f 1)
    
    if grep -q "^$param_name=" "$FILE"; then
        sed -i "/^$param_name=/c\\$param" "$FILE"
    else
        echo "$param" >> "$FILE"
    fi
}

for param in "${PARAMS[@]}"; do
    add_or_update_param "$param"
done
echo "# End property file" >> "$FILE"

echo "Polarion Properties Updated Successfully."
service polarion start

wait
tail -f /dev/null