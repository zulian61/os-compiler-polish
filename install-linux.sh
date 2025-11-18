#!/bin/bash

set -e

ARCH=$(uname -m)

case "$ARCH" in
  x86_64)
    NWJS_ARCH="x64"
    echo "Detected: Linux (x64)"
    ;;
  i686|i386)
    NWJS_ARCH="ia32"
    echo "Detected: Linux (x86)"
    ;;
  aarch64|arm64)
    VERSION="nw60-arm64_2022-01-08"
    URL="https://github.com/LeonardLaszlo/nw.js-armv7-binaries/releases/download/nw60-arm64_2022-01-08/${VERSION}.tar.gz"
    OUTPUT="nwjs.tar.gz"
    echo "Detected: Linux (ARM64)"
    ;;
  *)
    echo "ERROR: Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

if [ -z "$URL" ]; then
  VERSION="0.77.0"
  URL="https://dl.node-webkit.org/v${VERSION}/nwjs-v${VERSION}-linux-${NWJS_ARCH}.tar.gz"
  OUTPUT="nw.tar.gz"
fi

echo "Downloading $URL..."
curl -L -o "$OUTPUT" "$URL"

if [ ! -f "$OUTPUT" ]; then
  echo "ERROR: Download failed"
  exit 1
fi

echo "Extracting $OUTPUT..."
tar -xzf "$OUTPUT"