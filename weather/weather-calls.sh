#!/usr/bin/env bash

API_KEY=""
CITY=""
LATITUDE=""
LONGITUDE=""
UNITS="metric"
LANGUAGE="de"
forecast_data=""

init_forecast() {
  API_KEY=${1}
  CITY=${2}
  get_coordinates $CITY
  forecast_data=$(curl -s "https://api.openweathermap.org/data/3.0/onecall?units=metric&lang=${LANGUAGE}&lat=${LATITUDE}&lon=${LONGITUDE}&exclude=minutely,hourly&appid=${API_KEY}")
}

get_coordinates() {
  location_data=$(curl -s "http://api.openweathermap.org/geo/1.0/direct?q=${1}&limit=1&appid=aef9cd8db16eae5f11c21bd580fb46d0")
  LATITUDE=$(echo $location_data | jq -r '.[0].lat')
  LONGITUDE=$(echo $location_data | jq -r '.[0].lon')
}

get_main_city() {
  echo $CITY
}

calculate_timestamps() {
  local days=$1
  local date=$(date -u -d "+${days} days" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${date} 00:01" +%s)
  max_timestamp=$(date -u -d "${date} 23:59" +%s)
}


get_min_temp() {
  local days=$1
  calculate_timestamps $days
  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.min] | min")
}

get_max_temp() {
  local days=$1
  calculate_timestamps $days
  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.max] | max")
}

get_weather_descr() {
  local days=$1
  calculate_timestamps $days
  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .weather[0].description][0]")
}

get_weather_emoji() {
  local days=$1
  calculate_timestamps $days
  input_string=$(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .weather[0].icon][0]")
  case $input_string in
  "01d")
    echo "☀️"
    ;;
  "02d")
    echo "⛅"
    ;;
  "03d")
    echo "☁️"
    ;;
  "04d")
    echo "☁️"
    ;;
  "09d")
    echo "🌧️"
    ;;
  "10d")
    echo "🌧️"
    ;;
  "11d")
    echo "🌩️"
    ;;
  "50d")
    echo "🌫️"
    ;;
  *)
    echo "🖾"
    ;;
  esac
}

get_rain() {
  local days=$1
  calculate_timestamps $days
  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .pop][0]")
}

get_weather_morning() {
  local days=$1
  calculate_timestamps $days
  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.morn] | min")
}

get_weather_day() {
  local days=$1
  calculate_timestamps $days
  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.day] | max")
}

get_weather_night() {
  local days=$1
  calculate_timestamps $days
  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.night] | min")
}

get_uv() {
  local days=$1
  calculate_timestamps $days
  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .uvi] | max")
}

check_warnings() {
  warnings=$(echo "$forecast_data" | jq -r ".alerts[].event")
  if [ -z "$warnings" ]; then
    echo ""
  else
    echo "$warnings"
  fi
}