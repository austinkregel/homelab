#!/bin/bash
set -ex

sleep 20

cron 2>&1 > /var/www/html/logs/cron.log