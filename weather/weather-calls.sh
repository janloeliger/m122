#!/usr/bin/env bash

WEATHER_TOKEN=

API_KEY="7913b5e500551d85ae49133e93b0c953"
CITY="Zurich"
UNITS="metric"

get_weather() {
    curl -s "http://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=${UNITS}"
}

# Usage
weather_data=$(get_weather)
echo $weather_data