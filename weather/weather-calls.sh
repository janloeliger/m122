#!/usr/bin/env bash

API_KEY=""
CITY=""
UNITS=""
forecast_data=""

init_forecast() {
    API_KEY=${1}
    CITY=${2}
    UNITS=${3}
    forecast_data=$(curl -s "https://api.openweathermap.org/data/2.5/forecast?q=${CITY}&appid=${API_KEY}&units=${UNITS}")

    echo

    # Check if the API request was successful
    if [[ -z "$forecast_data" ]] || [[ "$forecast_data" == *"error"* ]]; then
        echo "Error: Unable to fetch forecast data. Please check your API key, city, and units."
        exit 1
    fi
}

get_min_temp() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
    # Get Unix timestamp for tomorrow at 00:01
    min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
    # Get Unix timestamp for tomorrow at 23:59
    max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

    min_temp=$(echo $forecast_data | jq -r "[.list[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .main.temp_min] | min")
    echo $min_temp
}

get_max_temp() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
    # Get Unix timestamp for tomorrow at 00:01
    min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
    # Get Unix timestamp for tomorrow at 23:59
    max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

    max_temp=$(echo $forecast_data | jq -r "[.list[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .main.temp_max] | max")
    echo $max_temp
}
