#!/bin/bash
mkdir $(pwd)/private
if cd katipo/apps/katipoHost && ./build.sh; then
cd ../../.. 
mkdir -p private/waraki
./katipo/apps/katipoHost/katipoHost --site waraki-site --privateSavePath private/waraki #will output config/database/saved files to
fi