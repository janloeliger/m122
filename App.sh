#!/usr/bin/env bash

# loads the libraries
source config/ConfigLoader.sh;
source weather/weather-calls.sh;

# initalizes the libraries
config_set_path "config/config.cfg" "config/config.cfg.default"
init_forecast $(config_get weather_token) $(config_get location) $(config_get unit_type)

#getting all needed values
emoji=$(get_weather_emoji_tomorrow)
min_temp=$(get_min_temp_tomorrow)
max_temp=$(get_max_temp_tomorrow)
rain=$(get_rain_tomorrow)
uv=$(get_uv_tomorrow)
descr=$(get_weather_descr_tomorrow)
day_weather=$(get_weather_day_tomorrow)
morning_weather=$(get_weather_morning_tomorrow)
night_weather=$(get_weather_night_tomorrow)

# creating the message
message="${emoji}${emoji}${emoji}"
message+="\n${descr}"
echo -e "$message"