#!/usr/bin/env bash

API_KEY="7913b5e500551d85ae49133e93b0c953"
CITY="Zurich"
UNITS="metric"
forecast_data=""

fetch_data() {
    forecast_data=$(curl -s "https://pro.openweathermap.org/data/2.5/forecast/hourly?q=${CITY}&appid=${API_KEY}&units=${UNITS}")
}

get_min_temp() {
    tomorrow=$(date -d "tomorrow" +"%Y-%m-%d")
    # Get Unix timestamp for tomorrow at 00:01
    max_timestamp=$(date -d "${tomorrow} 00:01" +%s)
    # Get Unix timestamp for tomorrow at 23:59
    min_timestamp=$(date -d "${tomorrow} 23:59" +%s)    # Extract tomorrow's forecast data
    tomorrow_forecast=$(echo ${forecast_data} | jq ".list[] | select(.dt_txt | startswith(\"${tomorrow}\"))")

    echo ${tomorrow_forecast} | jq -s 'min_by(.main.temp) | .main.temp'
}

get_max_temp() {
    echo ${tomorrow_forecast} | jq -s 'max_by(.main.temp) | .main.temp'
}

fetch_data

min_temp=$(get_min_temp)

echo "Max temperature for tomorrow: $max_temp"
echo "Min temperature for tomorrow: $min_temp"