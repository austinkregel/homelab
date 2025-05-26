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

mkdir -p appdata/{mailserver-postfix}/{config,dovecot,mail}
mkdir -p appdata/mailserver-postfix/config/sql