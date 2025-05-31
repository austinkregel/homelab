#!/bin/bash
set -ex

sleep 20
touch /var/www/html/logs/cron.log

cron 2>&1 > /var/www/html/logs/cron.log