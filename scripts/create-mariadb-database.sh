#!/usr/bin/env bash

mysql --user=root --password="$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS spork;
    GRANT ALL PRIVILEGES ON \`spork%\`.* TO '$MYSQL_USER'@'%';
    CREATE DATABASE IF NOT EXISTS authair;
    GRANT ALL PRIVILEGES ON \`authair%\`.* TO '$MYSQL_USER'@'%';
    CREATE DATABASE IF NOT EXISTS lazybuild;
    GRANT ALL PRIVILEGES ON \`lazybuild%\`.* TO '$MYSQL_USER'@'%';
    CREATE DATABASE IF NOT EXISTS consumer_information;
    GRANT ALL PRIVILEGES ON \`consumer_information%\`.* TO '$MYSQL_USER'@'%';
    CREATE DATABASE IF NOT EXISTS laradarr;
    GRANT ALL PRIVILEGES ON \`laradarr%\`.* TO '$MYSQL_USER'@'%';
EOSQL
