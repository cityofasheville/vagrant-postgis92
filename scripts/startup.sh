export PATH=$PATH:/usr/pgsql-9.2/bin
sudo service postgresql-9.2 initdb
sudo service postgresql-9.2 start
echo 'local   all             all                                     trust' |  sudo tee  /var/lib/pgsql/9.2/data/pg_hba.conf
echo 'host    all             all             10.0.2.2/32             trust' |  sudo tee --append /var/lib/pgsql/9.2/data/pg_hba.conf
echo "listen_addresses = '*'"  |  sudo tee --append /var/lib/pgsql/9.2/data/postgresql.conf
sudo service postgresql-9.2 restart
createdb -U postgres template_postgis
createlang -U postgres plpgsql template_postgis
psql -U postgres -d template_postgis -c "CREATE extension postgis;"
psql -U postgres -d template_postgis -c "CREATE extension postgis_topology;"
psql -U postgres -d template_postgis -c "CREATE extension fuzzystrmatch;"
psql -U postgres -d template_postgis -c "CREATE extension pg_trgm;"
psql -U postgres -d template_postgis -c "CREATE extension hstore;"
createdb -U postgres -E 'UTF8' -D pg_default -T template_postgis -O postgres coagis
uuidgen -r >pg.txt
echo -n "ALTER USER postgres with password '" > pg.txt; cat ps.txt  >>pg.txt ; echo -n "';" >> pg.txt
sed -i ':a;N;$!ba;s/\n//g' pg.txt
psql -U postgres -f pg.txt
echo 'local   all             all                                     trust' |  sudo tee  /var/lib/pgsql/9.2/data/pg_hba.conf
echo 'host    all             all             0.0.0.0/0             md5' |  sudo tee --append /var/lib/pgsql/9.2/data/pg_hba.conf
sudo service postgresql-9.2 restart