#!/bin/bash
set -ex

sleep 20

php artisan reverb:start --host=0.0.0.0 --port=6001