#!/usr/bin/env bash

set -ex

echo "Setting up the homelab repos..."

PROJECTS=(
    "aut.hair"
    "cannabis-consumer-information"
    "lazy.build"
    "spork"
    "laradarr"
)

for project in "${PROJECTS[@]}"; do
    mkdir -p appdata/"$project"
    echo "Creating the .env files..."
    curl "https://raw.githubusercontent.com/austinkregel/$project/refs/heads/main/.env.example" > "appdata/$project/.env"

    echo "Creating the start scripts for php apps files..."
    cp -f php-template-start.sh "appdata/$project/start.sh"

    echo "Creating the queue scripts for php apps files..."
    cp -f php-template-queue.sh "appdata/$project/queue.sh"
    
    echo "Creating the websocket scripts for php apps files..."
    cp -f php-template-websocket.sh "appdata/$project/queue.sh"

    echo "Creating the cron scripts for php apps files..."
    cp -f php-template-cron.sh "appdata/$project/cron.sh"
    cp -f laravel-crontab "appdata/$project/laravel-crontab"
    chmod +x "appdata/$project/start.sh" "appdata/$project/queue.sh" "appdata/$project/cron.sh"

    mkdir -p "appdata/$project/logs"
done

echo "Setting up the homelab repos complete."


touch appdata/prometheus/prometheus.yml

cat <<EOF > appdata/prometheus/prometheus.yml
global:
  scrape_interval: 10s
scrape_configs:
 - job_name: prometheus
   static_configs:
    - targets:
       - prometheus:9090
EOF