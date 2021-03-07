#!/bin/bash
set -eo pipefail

xcrun altool --upload-app -t ios -f "$IPA_PATH" -u "$APPLEID_USERNAME" -p "$APPLEID_PASSWORD" --verbose