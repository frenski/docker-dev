#!/bin/bash

#set -x

chown -R postgres:postgres /etc/postgresql/15/main/pg_hba.conf
chmod 0640 /etc/postgresql/15/main/pg_hba.conf

if [ ! -d /var/lib/postgresql/15 ]; then
   chown -R postgres:postgres /var/lib/postgresql
   runuser -u postgres -- /usr/lib/postgresql/15/bin/initdb -U postgres -D /var/lib/postgresql/15/main -E UTF8
fi

runuser -u postgres -- /usr/lib/postgresql/15/bin/postgres "-D" "/var/lib/postgresql/15/main" "-c" "config_file=/etc/postgresql/15/main/postgresql.conf" &
sleep 10
runuser -u postgres -- psql -c 'create database "vizlaipedia";'
runuser -u postgres -- psql -c "CREATE USER vizlaipedia WITH PASSWORD 'N0d3\$MEETN0d3\$'";
runuser -u postgres -- psql -c "grant all on database vizlaipedia to vizlaipedia";

if [ -s /restore/db.sql ]; then
   echo "Found SQL Dump file. Restoring the DB..."
   runuser -u postgres -- psql -c 'drop database "vizlaipedia";'
   runuser -u postgres -- psql -c 'create database "vizlaipedia";'
   runuser -u postgres -- pg_restore -U  postgres -d vizlaipedia /restore/db.sql
   runuser -u postgres -- psql -c "grant all on database vizlaipedia to vizlaipedia";
fi
cd /vizipedia
source venv/bin/activate
cd vizlaipedia-django
echo "Starting Vizlai...."
#python -c 'import sys;print("%s\n%s" % (sys.prefix, sys.base_prefix))'
python manage.py runserver 0.0.0.0:8000
