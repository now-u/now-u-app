#!/bin/sh
set -eo pipefail

gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/nowu.mobileprovision ./.github/secrets/nowu.mobileprovision.gpg
gpg --quiet --batch --yes --decrypt --passphrase="$IOS_KEYS" --output ./.github/secrets/AppStore-Distribution.p12 ./.github/secrets/AppStore-Distribution.p12.gpg

mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles

cp ./.github/secrets/nowu.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/nowu.mobileprovision


security create-keychain -p "" build.keychain
security import ./.github/secrets/AppStore-Distribution.p12 -t agg -k ~/Library/Keychains/build.keychain -P "$IOS_P12_KEY" -A

security list-keychains -s ~/Library/Keychains/build.keychain
security default-keychain -s ~/Library/Keychains/build.keychain
security unlock-keychain -p "" ~/Library/Keychains/build.keychain

security set-key-partition-list -S apple-tool:,apple: -s -k "" ~/Library/Keychains/build.keychain