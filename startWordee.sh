#!/bin/bash
mkdir $(pwd)/private
if cd katipo/apps/katipoHost && ./build.sh; then
cd ../../.. 
mkdir -p private/wordee
./katipo/apps/katipoHost/katipoHost --site wordee --privateSavePath private/wordee #will output config/database/saved files to
fi