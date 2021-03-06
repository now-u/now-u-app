#!/bin/bash
set -eo pipefail

security unlock-keychain -p "" ~/Library/Keychains/build.keychain
xcodebuild -workspace Runner.xcworkspace \
-scheme Runner \
-sdk iphoneos \
-configuration Release \
-archivePath $PWD/build/Runner.xcarchive \
clean archive | xcpretty