#!/usr/bin/env bash

set -ex

echo "Cleaning up the homelab repos..."

PROJECTS=(
    "aut.hair"
    "cannabis-consumer-information"
    "lazy.build"
    "spork"
    "laradarr"
)

for project in "${PROJECTS[@]}"; do
    mkdir -p appdata/"$project"
    echo "Deleting the copied files..."
    rm -f "appdata/$project/.env" "appdata/$project/start.sh" "appdata/$project/queue.sh" "appdata/$project/cron.sh" "appdata/$project/laravel-crontab"
done

echo "Sweeping up after the homelab complete."
