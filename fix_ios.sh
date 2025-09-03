#!/usr/bin/env bash
set -e

echo "🔧 Forcing iOS deployment target to 14.0..."

# Podfile
sed -i.bak "s/platform :ios, '.*'/platform :ios, '14.0'/" ios/Podfile || true

# AppFrameworkInfo.plist
plutil -replace MinimumOSVersion -string "14.0" ios/Flutter/AppFrameworkInfo.plist

# project.pbxproj
sed -i.bak "s/IPHONEOS_DEPLOYMENT_TARGET = [0-9.]\+/IPHONEOS_DEPLOYMENT_TARGET = 14.0/g" ios/Runner.xcodeproj/project.pbxproj || true

# Flutter clean & pub get
flutter clean
flutter pub get

# CocoaPods install
cd ios
pod repo update
pod install
cd ..

# Build iOS
flutter build ios --release --no-codesign
