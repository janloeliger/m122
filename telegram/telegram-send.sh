#!/usr/bin/env bash

GROUP_ID=${2}
BOT_TOKEN=${3}

curl -s --data-urlencode "text=$1" --data "chat_id=$GROUP_ID" --data "parse_mode=Markdown" "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" > /dev/null