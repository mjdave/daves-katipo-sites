#!/bin/bash
if cd katipo/apps/katipoHost && ./build.sh; then
cd ../../.. && ./katipo/apps/katipoHost/katipoHost --site warakiServer
fi