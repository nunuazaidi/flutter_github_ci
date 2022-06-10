#!/usr/bin/env bash

# Compiles the `shed` tool located in the `./shed` path and adds it to the `$GITHUB_PATH` environment variable so that
# it can be used by subsequent steps.
cd ./shed
dart pub get
dart compile exe bin/shed.dart -o shed
cd ..
echo "./shed" >> $GITHUB_PATH