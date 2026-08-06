#!/bin/bash
mkdir $(pwd)/private
if cd katipo/apps/katipoHost && ./build.sh; then
cd ../../.. 
mkdir -p private/solitaire
./katipo/apps/katipoHost/katipoHost --site solitaire --privateSavePath private/solitaire #will output config/database/saved files to
fi