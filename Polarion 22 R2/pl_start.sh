#! /bin/bash

systemctl stop polarion

# Define the file path
FILE="/opt/polarion/etc/polarion.properties"

# Other parameters to be added or updated
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

# Include the dynamic parameter in the array
PARAMS=(
    "$TomcatServiceRequestSafeListedHosts"
    "${OTHER_PARAMS[@]}"
)

# Temporarily remove end marker to avoid complications
sed -i '/^# End property file$/d' "$FILE"

# Function to add or update a parameter
add_or_update_param() {
    local param="$1"
    local param_name=$(echo "$param" | cut -d '=' -f 1)
    
    if grep -q "^$param_name=" "$FILE"; then
        # Parameter exists, update it
        sed -i "/^$param_name=/c\\$param" "$FILE"
    else
        # Parameter does not exist, append it
        echo "$param" >> "$FILE"
    fi
}

# Loop through all parameters and apply the add_or_update function
for param in "${PARAMS[@]}"; do
    add_or_update_param "$param"
done

# Re-add the end marker
echo "# End property file" >> "$FILE"

echo "Parameters updated or added successfully."

systemctl start polarion