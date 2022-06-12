#!/usr/bin/env bash

# Compiles the `shed` tool located in the `./build/shed` directory (downloaded by a prior step), and adds the resulting
# binary `shed` (located in the same directory) to the `$GITHUB_PATH` environment variable. This makes it available to
# subsequent steps.
#cd ./build/shed
#dart pub get
#dart compile exe bin/shed.dart -o shed
#cd ..
echo "./build/shed" >> $GITHUB_PATH