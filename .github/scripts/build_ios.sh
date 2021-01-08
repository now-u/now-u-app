#!/bin/bash
set -eo pipefail

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $GITHUB_RUN_NUMBER" "Runner/Info.plist"
xcodebuild -workspace Runner.xcworkspace \
-scheme Runner \
-sdk iphoneos \
-configuration Release \
-archivePath $PWD/build/Runner.xcarchive \
clean archive | xcpretty