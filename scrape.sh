#!/usr/bin/env bash

htmlOutput="/home/pi/Extended/eeoc.gov/html"
headerOutput="/home/pi/Extended/eeoc.gov/headers"

makeRequest() {
    url = "https://www.eeoc.gov/eeoc/newsroom/release/11-20-17.cfm"
    IFS='/' read -r -a array <<< "$string"
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
        
}

makeRequest
