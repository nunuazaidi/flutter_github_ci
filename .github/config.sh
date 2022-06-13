#!/usr/bin/env bash

# Sets up environment variables to be made available by all subsequent steps.
#
# Modifying these values will directly affect all steps in all workflows.
#
# Any sensitive information (such as secrets) should not be put in this file.
FLUTTER_VERSION=3.0.0
FLUTTER_CHANNEL=stable
DART_VERSION=2.17.0
SHED_VERSION=7e3e7f2f582be6b51bd6e30a29a629609e7418de

echo "FLUTTER_VERSION=$FLUTTER_VERSION" >> $GITHUB_ENV
echo "FLUTTER_CHANNEL=$FLUTTER_CHANNEL" >> $GITHUB_ENV
echo "DART_VERSION=$DART_VERSION" >> $GITHUB_ENV
echo "SHED_VERSION=$SHED_VERSION" >> $GITHUB_ENV