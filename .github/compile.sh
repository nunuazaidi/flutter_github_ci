#!/usr/bin/env bash

# Compiles the `shed` binary tool on the current platform so that subsequent steps can use it.
#
# The path containing the source (`./build/shed/src`) is kept separate from the path containing the compiled output
# binary (`./build/shed/out`) because both paths are cached in different steps.

# Navigate to the location of the source code, or exit with an error code if navigation fails.
# Navigating is necessary as `dart pub get` expects a `pubspec.yaml` file to be in the directory where it's run.
cd ./build/shed/src || exit 1

# Fetch all dependencies and compile the binary output with the name `tool`, located in the root directory of the
# project (`./build/shed/src`).
dart pub get
dart compile exe bin/shed.dart -o tool

# Move to the `./build/shed` directory and make another directory named `out` specifically for the compiled binary.
cd ../
mkdir out

# Move the compiled binary `./build/shed/src/tool` into the `./build/shed/out` directory, giving it the `shed` name.
mv ./src/tool ./out/shed