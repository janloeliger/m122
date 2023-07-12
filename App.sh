#!/usr/bin/env bash

# sets the logger
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
LOG_FILE="${SCRIPT_DIR}/log.txt"
exec 1>>"$LOG_FILE" 2>&1

# Log script execution start
echo "$(date +"%Y-%m-%d %H:%M:%S") : Script execution started" >> "$LOG_FILE"

# loads the libraries
source config/ConfigLoader.sh;
source weather/weather-calls.sh;

# initalizes the libraries
config_set_path "config/config.cfg" "config/config.cfg.default"
init_forecast $(config_get weather_token) $(config_get location)

send_weather() {
  days=$(config_get forecast_length_days)

  message=""
  for i in $(seq 1 $days)
  do
      #getting all needed values
      emoji=$(get_weather_emoji $i)
      min_temp=$(get_min_temp $i)
      max_temp=$(get_max_temp $i)
      rain=$(get_rain $i)
      rain_percent=$(echo "$rain * 100" | bc)
      uv=$(get_uv $i)
      descr=$(get_weather_descr $i)
      day_weather=$(get_weather_day $i)
      morning_weather=$(get_weather_morning $i)
      night_weather=$(get_weather_night $i)
      date_string=$(date -u -d "+${i} days" +"%Y-%m-%d")

      # creating the message
      message+="*$emoji$emoji$emoji*    
  Folgendes Wetter wird für *$(config_get location)* _am_ *${date_string}* erwartet:
  ${descr} mit einer Höchsttemperatur von *${max_temp}°* und einer Tiefsttemperatur von *${min_temp}°*
  Einen UV-Index von *${uv}*
  Durch den gesamten Tag gibt es eine Regenwahrscheinlichkeit von *${rain_percent}%*


  Die Temperaturen zu verschiedenen Tageszeiten sind:
  Am Morgen wird eine Temperatur von *${morning_weather}°* erwartet
  Zu der Mittagszeit wird eine Temperatur von *${day_weather}°* erwartet
  In der Nacht wird es *${night_weather}°* kühl

      ------------

  "
  done

  # send via telegram as Markdown
  source telegram/telegram-send.sh "$message" "$(config_get telegram_chat_token)" "$(config_get telegram_bot_token)"
  # Log script execution end
  echo "$(date +"%Y-%m-%d %H:%M:%S") : Sent daily weather forecast via Telegram to user" >> "$LOG_FILE"
}

check_emergencies() {
  local emergencies=$(check_warnings)
  if [ "$emergencies" != "" ]; then
    # send emergencies via Telegram
    source telegram/telegram-send.sh "$emergencies"
    echo "$(date +"%Y-%m-%d %H:%M:%S") : Emergency warnings sent via Telegram."
  fi
}

# Check if required configuration values are filled
if [[ -z $(config_get weather_token) || -z $(config_get location) || -z $(config_get telegram_chat_token) || -z $(config_get telegram_bot_token) || -z $(config_get forecast_length_days) ]]; then
  echo "Please fill in the required configuration values: weather_token, location" >>"$LOG_FILE"
  exit 1
fi

echo 

if [ $1 = "true" ]; then
  # Check for emergencies and send via Telegram
  check_emergencies
elif [ $1 = "false" ]; then
  send_weather
else
  echo "$(date +"%Y-%m-%d %H:%M:%S") : Invalid argument. Please provide either 'true' or 'false'."
fi


