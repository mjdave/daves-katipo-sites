#!/bin/bash
if cd katipo/apps/katipoHost && ./build.sh; then
./katipoHost --site ../../../katipobrowser.com
fi