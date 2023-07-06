#!/usr/bin/env bash
configfile=""
default_configfile=""

config_set_path() {
    configfile=${1}
    default_configfile=${2}
}

config_read_file() {
    (grep -E "^${2}=" -m 1 "${1}" 2>/dev/null || echo "VAR=__UNDEFINED__") | head -n 1 | cut -d '=' -f 2-;
}

config_get() {
    val="$(config_read_file "${configfile}" "${1}")";
    if [ "${val}" = "__UNDEFINED__" ]; then
        val="$(config_read_file "${default_configfile}" "${1}")";
    fi
    printf -- "%s" "${val}";
}