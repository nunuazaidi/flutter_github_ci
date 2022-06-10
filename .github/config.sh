#!/usr/bin/env bash

# Environment variables used by all other steps, loaded in with the help of the 'md' tool (located in the root directory
# of the project).
FLUTTER_VERSION=3.0.0
FLUTTER_CHANNEL=stable
DART_VERSION=2.17.0

echo "FLUTTER_VERSION=$FLUTTER_VERSION" >> $GITHUB_ENV
echo "FLUTTER_CHANNEL=$FLUTTER_CHANNEL" >> $GITHUB_ENV
echo "DART_VERSION=$DART_VERSION" >> $GITHUB_ENV