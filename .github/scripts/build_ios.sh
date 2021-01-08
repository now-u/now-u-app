#!/bin/bash
set -eo pipefail

xcodebuild -workspace Runner.xcworkspace \
-scheme Runner \
-sdk iphoneos \
-configuration Release \
-archivePath $PWD/build/Runner.xcarchive \
clean archive | xcpretty