#! /bin/sh
set -ex
sleep 10

# Check if a key already exists, otherwise create it calling the grafana API and store it
echo "Checking key"

if [ ! -f /opt/key/key ]
then
    GRAFANA_KEY=$(curl -X POST -H "Content-Type: application/json" -d '{"name":"apikey_'$RANDOM'", "role": "Admin"}' http://admin:admin@grafana:3000/api/auth/keys | jq -r '.key')
    echo $GRAFANA_KEY > /opt/key/key
else
    GRAFANA_KEY=$(cat /opt/key/key)
fi


# Check if the data source already exists, if not, create it
echo "Checking datasource"

DATASOURCE=$(curl -X GET http://admin:admin@grafana:3000/api/datasources/name/Prometheus | jq -r '.id')

if [ "$DATASOURCE" == null ]
then
    curl -X POST \
    --insecure \
    -H "Authorization: Bearer ${GRAFANA_KEY}" \
    -H "Content-Type: application/json" \
    -d '{
    "name":"Prometheus",
    "type":"prometheus",
    "url": "http://prometheus:9090",
    "isDefault": true,
    "readOnly": false,
    "access":"proxy",
    "jsonData": {},
    "basicAuth":false
    }' \
    http://grafana:3000/api/datasources
fi

# Reading boards from the import directory and create them
# If the board already exists, this will ignore the error
echo "Creating boards"

for board in /opt/import/*.json; do
    CONTENT=$(cat ${board})
    
    curl -X POST \
    --insecure \
    -H "Authorization: Bearer ${GRAFANA_KEY}" \
    -H "Content-Type: application/json" \
    -d @$board \
    http://grafana:3000/api/dashboards/db
done

exit 0
