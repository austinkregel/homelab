#!/bin/bash
set -ex
php artisan migrate --force
npm i
npm run build
php artisan serve --port=8000 --host=0.0.0.0 --silent
