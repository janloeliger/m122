#!/bin/bash

# Specify the script and its path
SCRIPT_PATH="/path/to/your/App.sh"

TEMP_FILE=$(mktemp)

echo "*/5 * * * * $SCRIPT_PATH true" >> "$TEMP_FILE"
echo "0 19 * * * $SCRIPT_PATH false" >> "$TEMP_FILE"
crontab "$TEMP_FILE"
rm "$TEMP_FILE"

echo "Cron jobs added successfully."