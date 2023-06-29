#!/usr/bin/env bash
source config/ConfigLoader.sh; # load the config library functions
echo "$(config_get myvar)"; # will be found in user-cfg
printf -- "%s\n" "$(config_get myvar)"; # safer way of echoing!
myvar="$(config_get myvar)"; # how to just read a value without echoing
echo "$(config_get othervar)"; # will fall back to defaults
echo "$(config_get not_a_var)"; # "__UNDEFINED__" since it isn't set anywhere