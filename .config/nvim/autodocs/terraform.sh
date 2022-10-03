#!/bin/bash


TYPE=$(echo "$@" | sed 's|"| |g' | awk '{print $1}')
NAME=$(echo "$@" | sed 's|"| |g' | awk '{print $2}')
PROVIDER=$(echo "$NAME" | sed 's|_.*||')
AWS_PROVIDER_URL=https://registry.terraform.io/providers/hashicorp/${PROVIDER}/latest/docs

echo "Type: $TYPE"
echo "Name: $NAME"
echo "Provider: $PROVIDER"

if [ $TYPE = "resource" ] ; then
    PART=resources
elif [ $TYPE = "data" ] ; then
    PART=data-sources
else
    echo "Unknown terraform type: $TYPE. Known types are \"resources\" and \"data\". Please search documentation by placing the cursor in a \"resource\" or \"data\" line."
    exit 1
fi

RESOURCE_NAME_FULL="$NAME"
RESOURCE_NAME_TRIMMED=$(echo $NAME | sed "s/${PROVIDER}_//")

URL="${AWS_PROVIDER_URL}/${PART}/${RESOURCE_NAME_TRIMMED}"
echo "Trying url $URL"
open $URL

echo -ne "Doc found? [y/n] "
read found

[[ $found = y ]] && exit 0

URL="${AWS_PROVIDER_URL}/${PART}/${RESOURCE_NAME_FULL}"
echo "Trying url $URL"
open $URL

echo -ne "Doc found? [y/n] "
read found

[[ $found = y ]] && exit 0

URL="https://www.google.com/search?q=terraform%20${NAME}"
echo "Trying with google at url $URL"
open $URL

