#!/bin/bash
if cd katipo/apps/katipoTracker && ./build.sh; then
cd ../../.. && ./katipo/apps/katipoTracker/katipoTracker --defaultHost katipo
fi