#!/usr/bin/env bash

API_KEY=""
CITY=""
LATITUDE=""
LONGITUDE=""
UNITS=""
LANGUAGE="de"
forecast_data=""

init_forecast() {
  API_KEY=${1}
  CITY=${2}
  UNITS=${3}
  get_coordinates $CITY
  forecast_data=$(curl -s "https://api.openweathermap.org/data/3.0/onecall?units=metric&lang=${LANGUAGE}&lat=${LATITUDE}&lon=${LONGITUDE}&exclude=minutely,hourly&appid=aef9cd8db16eae5f11c21bd580fb46d0")
}

get_coordinates() {
  location_data=$(curl -s "http://api.openweathermap.org/geo/1.0/direct?q=${1}&limit=1&appid=aef9cd8db16eae5f11c21bd580fb46d0")
  LATITUDE=$(echo $location_data | jq -r '.[0].lat')
  LONGITUDE=$(echo $location_data | jq -r '.[0].lon')
}

get_min_temp_tomorrow() {
  tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.min] | min")
}

get_max_temp_tomorrow() {
  tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.max] | max")
}

get_weather_descr_tomorrow() {
  tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .weather[0].description][0]")
}

get_weather_emoji_tomorrow() {
  tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

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
  "13d")
    echo "❄️"
    ;;
  "50d")
    echo "🌫️"
    ;;
  *)
    echo "🖾"
    ;;
  esac
}

get_rain_tomorrow() {
  tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .pop][0]")
}

get_weather_morning_tomorrow() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.morn] | min")
}

get_weather_day_tomorrow() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.day] | max")
}

get_weather_night_tomorrow() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.night] | min")
}

get_uv_tomorrow() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .uvi] | max")
}