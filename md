#!/usr/bin/env bash

# Helper tool to make a given command (supplied via the first argument) executable and run it in one go.
# This tool is used by multiple workflow steps located in the `./github/workflows/` directory.
chmod +x $1 && $1