#!/bin/bash -l

if [ -z "$MEM_ALERT_THRESHOLD" ]; then
    echo "MEM_ALERT_THRESHOLD is not set"
    exit 1
fi

if [ -z "$SERVER_NAME" ]; then
    echo "SERVER_NAME is not set"
    exit 1
fi

send_email () {
    local to=$1
    local from=$2
    local subject=$3
    local body=$4

    curl --request POST \
        --url https://api.sendgrid.com/v3/mail/send \
        --header "Authorization: Bearer $SENDGRID_API_KEY" \
        --header 'Content-Type: application/json' \
        --data '{"personalizations": [{"to": [{"email": "'$to'"}]}],"from": {"email": "'"$from"'"},"subject": "'"$subject"'","content": [{"type": "text/plain", "value": "'"$body"'"}]}'
}


MEBIBYTES_FREE=$(free -m |
    awk 'NR == 2 && $3/$2 > ENVIRON["MEM_ALERT_THRESHOLD"] { print $4 }')

# Awk returned nothing, so we're good
if [ -z "$MEBIBYTES_FREE" ]; then
    exit 0
fi

BODY="Memory usage exceeded threshold of $MEM_ALERT_THRESHOLD. Mebibytes free: $MEBIBYTES_FREE"

send_email $ALERT_TO_EMAIL $ALERT_FROM_EMAIL "Low memory on $SERVER_NAME" "$BODY"
