#!/usr/bin/env bash

FILE_SIZE_THRESHOLD=4325
DELAY_TIME_SECONDS=60
REQUEST_DELAY_SECONDS=10
MAX_REQUEST_DELAY_SECONDS=15
MIN_REQUEST_DELAY_SECONDS=1

htmlOutput="/home/pi/Extended/eeoc.gov/html"
headerOutput="/home/pi/Extended/eeoc.gov/headers"

makeRequest() {
    url=$1
    IFS='/' read -r -a array <<< "$url"
    fileName=${array[-1]} #echo "${array[@]: -1:1}"
    #readarray -td/ a <<<"$url"; declare -p a;

    curl --silent \
        --get \
        --verbose \
        --location \
        --request GET \
        --data renderforprint=1 \
        --dump-header "$headerOutput/${fileName}.txt" \
        --cookie-jar "./cookies_out.txt" \
        --output "$htmlOutput/$fileName.html" \
        "$url" 1> /dev/null 2>&1

    echo "$fileName.html"
}

cleanFile(){
    fileName=$1
    echo "$(cat $htmlOutput/$fileName | ./htmlCleaner.js)" > "$htmlOutput/$fileName"
}

while read url; do
    fileName=`makeRequest "$url"`
    echo "fileName= '$fileName'"
    cleanFile "$fileName"

    let "rdelay = ($RANDOM % ($MAX_REQUEST_DELAY_SECONDS - $MIN_REQUEST_DELAY_SECONDS)) + 1"
    echo "Delaying: $rdelay seconds"
    sleep $rdelay
done

exit 0
