#!/usr/bin/env bash

# loads the libraries
source config/ConfigLoader.sh;
source weather/weather-calls.sh;

# initalizes the libraries
config_set_path "config/config.cfg" "config/config.cfg.default"
echo $(config_get weather_token) $(config_get location) $(config_get unit_type)
init_forecast $(config_get weather_token) $(config_get location) $(config_get unit_type)
echo $(get_max_temp)
