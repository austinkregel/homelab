#!/usr/bin/env bash
set -ex
npm i
npm run build

apt install php8.2-{mysql,pdo} -y
composer install

php artisan migrate --force
php artisan serve --port=8000 --host=0.0.0.0
