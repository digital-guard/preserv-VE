#!/bin/bash



# layer building:
rm -rf /tmp/sandbox/_pk86200000201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk86200000201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar && sudo chmod 664 /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk86200000201101_p1_building CASCADE"
cd /tmp/sandbox/_pk86200000201_001; 7z  x -y /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar "*EDIFICACIONES_RV*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32619"
cd /tmp/sandbox/_pk86200000201_001; shp2pgsql -D -W ISO-8859-1  -s 32619 "EDIFICACIONES_RV.shp" pk86200000201101_p1_building | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk86200000201101_p1_building AS SELECT row_number() OVER () as gid, \
geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/EDIFICACIONES_RV.shp','building_none','vw1_pk86200000201101_p1_building','86200000201101','06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk86200000201101_p1_building"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk86200000201101_p1_building CASCADE"
rm -f /tmp/sandbox/_pk86200000201_001/*EDIFICACIONES_RV.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/building
rm -rf /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/building/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('building','VE-M-Baruta','/var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/building','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/building
sudo find /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/building -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/building -type f -exec chmod 664 {} \;




# layer geoaddress:
rm -rf /tmp/sandbox/_pk86200000201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk86200000201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar && sudo chmod 664 /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk86200000201101_p1_geoaddress CASCADE"
cd /tmp/sandbox/_pk86200000201_001; 7z  x -y /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar "*INMUEBLE_CATASTRADO_PTO*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32619"
cd /tmp/sandbox/_pk86200000201_001; shp2pgsql -D -W ISO-8859-1  -s 32619 "INMUEBLE_CATASTRADO_PTO.shp" pk86200000201101_p1_geoaddress | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk86200000201101_p1_geoaddress AS SELECT row_number() OVER () as gid, sector, manzana, parcela, sub_parcel, n_civico as hnum, \
nom_urb as nsvia, via_acceso as via, nom_inmueb, nom_edif_m, tipo_inm, uso, orig_fid, \
geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/INMUEBLE_CATASTRADO_PTO.shp','geoaddress_full','vw1_pk86200000201101_p1_geoaddress','86200000201101','06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar',array[]::text[],1,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk86200000201101_p1_geoaddress"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk86200000201101_p1_geoaddress CASCADE"
rm -f /tmp/sandbox/_pk86200000201_001/*INMUEBLE_CATASTRADO_PTO.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/geoaddress
rm -rf /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/geoaddress/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('geoaddress','VE-M-Baruta','/var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/geoaddress','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/geoaddress
sudo find /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/geoaddress -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/geoaddress -type f -exec chmod 664 {} \;

# layer nsvia:
rm -rf /tmp/sandbox/_pk86200000201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk86200000201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar && sudo chmod 664 /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk86200000201101_p1_nsvia CASCADE"
cd /tmp/sandbox/_pk86200000201_001; 7z  x -y /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar "*URBANIZACIONES_RV*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32619"
cd /tmp/sandbox/_pk86200000201_001; shp2pgsql -D -W ISO-8859-1  -s 32619 "URBANIZACIONES_RV.shp" pk86200000201101_p1_nsvia | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk86200000201101_p1_nsvia AS SELECT row_number() OVER () as gid, nom_urb as nsvia, cod_urb, tipo_desar, pob_1998, por_sector, \
geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/URBANIZACIONES_RV.shp','nsvia_full','vw1_pk86200000201101_p1_nsvia','86200000201101','06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk86200000201101_p1_nsvia"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk86200000201101_p1_nsvia CASCADE"
rm -f /tmp/sandbox/_pk86200000201_001/*URBANIZACIONES_RV.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/nsvia
rm -rf /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/nsvia/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('nsvia','VE-M-Baruta','/var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/nsvia','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/nsvia
sudo find /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/nsvia -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/nsvia -type f -exec chmod 664 {} \;


# layer via:
rm -rf /tmp/sandbox/_pk86200000201_001 || true
mkdir -m 777 -p /tmp/sandbox
mkdir -m 777 -p /tmp/sandbox/_pk86200000201_001
mkdir -p /tmp/pg_io
wget -P /var/www/dl.digital-guard.org http://dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar
sudo chown postgres:www-data /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar && sudo chmod 664 /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk86200000201101_p1_via CASCADE"
cd /tmp/sandbox/_pk86200000201_001; 7z  x -y /var/www/dl.digital-guard.org/06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar "*CENTROS_DE_VIAS_RV*" ; chmod -R a+rwx . > /dev/null
psql postgres://postgres@localhost/ingest1 -c "SELECT srid, proj4text FROM spatial_ref_sys where srid=32619"
cd /tmp/sandbox/_pk86200000201_001; shp2pgsql -D -W ISO-8859-1  -s 32619 "CENTROS_DE_VIAS_RV.shp" pk86200000201101_p1_via | psql -q postgres://postgres@localhost/ingest1 2> /dev/null

psql postgres://postgres@localhost/ingest1 -c "CREATE VIEW vw1_pk86200000201101_p1_via AS SELECT row_number() OVER () as gid, urbaniza as nsvia, tipo_via, nom_via, nom_conc as via,\
geom \
FROM $(tabname)"
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.any_load('shp2sql','/tmp/sandbox/CENTROS_DE_VIAS_RV.shp','via_full','vw1_pk86200000201101_p1_via','86200000201101','06c5461d0c7bdebd504d4033bab337b2d7a4aa236562e0704b9e49bc926a1fba.rar',array[]::text[],5,1)"
psql postgres://postgres@localhost/ingest1 -c "DROP VIEW vw1_pk86200000201101_p1_via"
@echo "Confira os resultados nas tabelas ingest.donated_packcomponent e ingest.feature_asis".
psql postgres://postgres@localhost/ingest1 -c "DROP  TABLE IF EXISTS pk86200000201101_p1_via CASCADE"
rm -f /tmp/sandbox/_pk86200000201_001/*CENTROS_DE_VIAS_RV.* || true
mkdir -m777 -p /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/via
rm -rf /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/via/*.geojson
psql postgres://postgres@localhost/ingest1 -c "SELECT ingest.publicating_geojsons('via','VE-M-Baruta','/var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/via','1',9,3);"
sudo chown -R postgres:www-data /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/via
sudo find /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/via -type d -exec chmod 774 {} \;
sudo find /var/gits/_dg/preservCutGeo-VE2021/data/M/Baruta/_pk0002.01/via -type f -exec chmod 664 {} \;




