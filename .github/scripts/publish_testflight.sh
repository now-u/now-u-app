#!/bin/bash
set -eo pipefail

xcrun altool --upload-app -t ios -f build/build/app/outputs/ios/release/app-release.ipa -u "$APPLEID_USERNAME" -p "$APPLEID_PASSWORD" --verbose