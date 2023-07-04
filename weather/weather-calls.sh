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

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .weather[0].description]")
}

get_weather_emoji_tomorrow() {
  tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  input_string=$(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .weather[0].icon]")
  emoji=""
  case $input_string in
  "01d")
    emoji="☀️"
    ;;
  "02d")
    emoji="⛅"
    ;;
  "03d")
    emoji="☁️"
    ;;
  "04d")
    emoji="☁️"
    ;;
  "09d")
    emoji="🌧️"
    ;;
  "10d")
    emoji="🌧️"
    ;;
  "11d")
    emoji="🌩️"
    ;;
  "13d")
    emoji="❄️"
    ;;
  "50d")
    emoji="🌫️"
    ;;
  *)
    emoji="🖾"
    ;;
  esac

  echo $emoji
}

get_rain_tomorrow() {
  tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .pop]")
}

get_weather_morning_tomorrow() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.morn]")
}

get_weather_day_tomorrow() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.day]")
}

get_weather_night_tomorrow() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .temp.night]")
}

get_uv_tomorrow() {
    tomorrow=$(date -u -d "tomorrow" +"%Y-%m-%d")
  min_timestamp=$(date -u -d "${tomorrow} 00:01" +%s)
  max_timestamp=$(date -u -d "${tomorrow} 23:59" +%s)

  echo $(echo $forecast_data | jq -r "[.daily[] | select(.dt >= $min_timestamp and .dt <= $max_timestamp) | .uvi]")
}