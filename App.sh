#!/usr/bin/env bash

# loads the libraries
source config/ConfigLoader.sh;
source weather/weather-calls.sh;

# initalizes the libraries
config_set_path "config/config.cfg" "config/config.cfg.default"
init_forecast $(config_get weather_token) $(config_get location)

#getting all needed values
emoji=$(get_weather_emoji_tomorrow)
min_temp=$(get_min_temp_tomorrow)
max_temp=$(get_max_temp_tomorrow)
rain=$(get_rain_tomorrow)
rain_percent=$(echo "$rain * 100" | bc)
uv=$(get_uv_tomorrow)
descr=$(get_weather_descr_tomorrow)
day_weather=$(get_weather_day_tomorrow)
morning_weather=$(get_weather_morning_tomorrow)
night_weather=$(get_weather_night_tomorrow)

# creating the message
message="$emoji$emoji$emoji
Folgendes Wetter wird für $(config_get location) erwartet:
- ${descr} mit einer Höchsttemperatur von ${max_temp}° und einer Tiefsttemperatur von ${min_temp}°
- Einen UV-Index von ${uv}
- Durch den gesamten Tag gibt es eine Regenwahrscheinlichkeit von ${rain_percent}%

Die Temperaturen zu verschiedenen Tageszeiten sind:
- Am Morgen wird eine Temperatur von ${morning_weather}° erwartet
- Zu der Mittagszeit wird eine Temperatur von ${day_weather}° erwartet
- In der Nacht wird es ${night_weather}° kühl
"

# send via telegram
source telegram/telegram-send.sh "$message";
