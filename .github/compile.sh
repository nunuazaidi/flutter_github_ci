#!/usr/bin/env bash

cd ./shed
dart pub get
dart compile exe bin/shed.dart -o shed
cd ..
echo "./shed" >> $GITHUB_PATH