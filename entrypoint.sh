#!/bin/bash

touch /var/log/cron.log
echo "$CRON_SCHEDULE /app/venv/bin/python3 /app/hdhomerun.py > /proc/1/fd/1 2>/proc/1/fd/2 && chown $PUID:$GUID /app/output/hdhomerun.xml" > /var/spool/cron/crontabs/root
echo "" >> /var/spool/cron/crontabs/root
chmod 0644 /var/spool/cron/crontabs/root
crontab -u root /var/spool/cron/crontabs/root

if $RUN_IMMEDIATELY
then
    /app/venv/bin/python3 /app/hdhomerun.py > /proc/1/fd/1 2>/proc/1/fd/2 && chown $PUID:$GUID /app/output/hdhomerun.xml
fi

echo "Waiting until scheduled cron event: $CRON_SCHEDULE"
cron && tail -f /var/log/cron.log