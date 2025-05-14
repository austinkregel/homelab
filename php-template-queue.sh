#!/bin/bash
set -ex

# When we start, we basically want to wait for the database to be migrated by the base script
sleep 20
php artisan horizon
