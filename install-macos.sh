#!/bin/bash

set -e

ARCH=$(uname -m)

case "$ARCH" in
  x86_64)
    NWJS_ARCH="x64"
    echo "Detected: MacOS (x64)"
    ;;
  arm64)
    NWJS_ARCH="arm64"
    echo "Detected: MacOS (ARM64)"
    ;;
  *)
    echo "ERROR: Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

VERSION="0.77.0"
URL="https://dl.node-webkit.org/v${VERSION}/nwjs-v${VERSION}-osx-${NWJS_ARCH}.zip"
OUTPUT="nw.zip"

echo "Downloading $URL..."
curl -L -o "$OUTPUT" "$URL"

if [ ! -f "$OUTPUT" ]; then
  echo "ERROR: Download failed"
  exit 1
fi

echo "Extracting $OUTPUT..."
unzip -q "$OUTPUT"