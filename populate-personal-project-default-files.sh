#!/usr/bin/env bash
set -e
declare -A PROJECTS=([authair]="laravel-app,laravel-queue,laravel-cron" [cannabis_consumer_information]="laravel-app,laravel-queue,laravel-cron" [lazybuild]="laravel-app" [spork]="laravel-app,laravel-queue,laravel-cron" [laradarr]="laravel-app,laravel-queue,laravel-cron")

BASE_TEMPLATE_DIR="$(dirname "$(realpath "$0")")/templates"


do_project_build() {
    local project="$1"
    local project_dir="apps/$project"
    local project_template_dir="$BASE_TEMPLATE_DIR/$project"

    mkdir -p "$project_dir"

    echo "Creating the .env files..."

    IFS=',' read -r -a templates <<< "${PROJECTS[$project]}"

    for template in "${!templates[*]}"; do
        case $template in
            laravel-app)
                cp -f "$project_template_dir/php-template-start.sh" "$project_dir/start.sh"
                ;;
            laravel-queue)
                cp -f "$project_template_dir/php-template-queue.sh" "$project_dir/queue.sh"
                ;;
            laravel-cron)
                cp -f "$project_template_dir/php-template-cron.sh" "$project_dir/cron.sh"
                cp -f "$project_template_dir/laravel-crontab" "$project_dir/laravel-crontab"
                ;;
        esac
    done

    chmod +x "$project_dir/start.sh" "$project_dir/queue.sh" "$project_dir/cron.sh"

    mkdir -p "$project_dir/logs"
}


for project in "${!PROJECTS[@]}"; do
    do_project_build "$project" "${PROJECTS[$project]}"
done