#!/usr/bin/env bash
set -e

echo "🔧 Forcing iOS deployment target to 14.0..."

# 1. Update Podfile
sed -i.bak "s/platform :ios, '.*'/platform :ios, '14.0'/" ios/Podfile || true

# 2. Update AppFrameworkInfo.plist
plutil -replace MinimumOSVersion -string "14.0" ios/Flutter/AppFrameworkInfo.plist

# 3. Update project.pbxproj
sed -i.bak "s/IPHONEOS_DEPLOYMENT_TARGET = [0-9.]\+/IPHONEOS_DEPLOYMENT_TARGET = 14.0/g" ios/Runner.xcodeproj/project.pbxproj || true

# Run Flutter clean & pub get (to ensure fresh build)
flutter clean
flutter pub get

# Install CocoaPods
cd ios
pod repo update
pod install
cd ..

# Finally build iOS without codesign
flutter build ios --release --no-codesign
