#!/bin/bash

# Set default backup interval if not provided
BACKUP_INTERVAL=${BACKUP_INTERVAL:-120}

while true; do
echo "================================================" >> /app/logs/cron.log
echo "Starting notionbackup at $(date)" >> /app/logs/cron.log
echo "================================================" >> /app/logs/cron.log

echo "Checking if notionconverter is executable..." >> /app/logs/cron.log

# Check if notionconverter is executable (it is a python script installed and usable via notionconverter)
if [ ! -x /usr/local/bin/notionconverter ]; then
    echo "notionconverter is not executable or not installed!" >> /app/logs/cron.log
    exit 1
fi

# Run notionconverter with environment variables
echo "Running notionconverter..." >> /app/logs/cron.log
/usr/local/bin/notionconverter >> /app/logs/cron.log
echo "Notionbackup completed." >> /app/logs/cron.log

sleep ${BACKUP_INTERVAL}
done