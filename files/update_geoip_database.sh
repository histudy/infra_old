#!/bin/bash

cd /tmp || exit 1
wget -q https://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
if [ -f GeoIP.dat.gz ]; then
    gzip -d -f GeoIP.dat.gz
    rm -f /usr/share/GeoIP/GeoIP.dat
    mv -f GeoIP.dat /usr/share/GeoIP/GeoIP.dat
fi
exit 0
