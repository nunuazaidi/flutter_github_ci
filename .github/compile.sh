#!/usr/bin/env bash

cd ./build/shed/src || exit
dart pub get
dart compile exe bin/shed.dart -o tool
cd ../
mkdir out
mv ./src/tool ./out/shed