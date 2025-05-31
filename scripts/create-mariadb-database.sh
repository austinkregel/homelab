#!/usr/bin/env bash


TABLES=(
    "spork"
    "authair"
    "lazybuild"
    "consumer_information"
    "laradarr"
    "postfix"
    "opendkim"
    "postfixadmin"
    "roundcube"
    "vito"
    "monica"
)

for table in "${TABLES[@]}"; do
    if [[ ! -d "/var/lib/mysql/$table" ]]; then
        echo "Creating database $table"
        mysql --user=root --password="$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $table;"
        mysql --user=root --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$table%\`.* TO '$MYSQL_USER'@'%';"
        echo "Created database $table; and granted privileges to $MYSQL_USER."
    else
        mysql --user=root --password="$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON \`$table%\`.* TO '$MYSQL_USER'@'%';"
        echo "Database $table already exists, ensuring $MYSQL_USER has access."
    fi
done