export PATH=$PATH:/usr/pgsql-9.2/bin
sudo service postgresql-9.2 initdb
sudo service postgresql-9.2 start
echo 'local   all             all                                     trust' >  /var/lib/pgsql/9.2/data/pg_hba.conf
echo 'host    all             all             10.0.2.2/32             trust' >>  /var/lib/pgsql/9.2/data/pg_hba.conf

echo "listen_addresses = '*'"  >> /var/lib/pgsql/9.2/data/postgresql.conf
sudo service postgresql-9.2 reetart
createdb -U postgres template_postgis
createlang -U postgres plpgsql template_postgis
psql - U postgres -d template_postgis -c "CREATE extension postgis;"
psql -U postgres -d template_postgis -c "CREATE extension postgis;"
psql -U postgres -d template_postgis -c "CREATE extension postgis_toplogy;"
psql -U postgres -d template_postgis -c "CREATE extension postgis_topology;"
psql -U postgres -d template_postgis -c "CREATE extension fuzzystrmatch;"
psql -U postgres -d template_postgis -c "CREATE extension pg_trgm;"
psql -U postgres -d template_postgis -c "CREATE extension hstore;"
createdb -U postgres -E 'UTF8' -D pg_default -T template_postgis -O postgres coagis
