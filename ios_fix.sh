#!/bin/bash
# iOS Build Fix Script for Flutter
# This script cleans up and regenerates the iOS build files

echo "🧹 Cleaning iOS build artifacts..."

# Remove Pods and related files
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf ios/.symlinks
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec
rm -rf ios/Flutter/Generated.xcconfig
rm -rf ios/Flutter/flutter_export_environment.sh
rm -rf ios/Pods/Manifest.lock

# Clean Flutter build
echo "🧹 Cleaning Flutter build..."
flutter clean

# Get dependencies
echo "📦 Getting Flutter dependencies..."
flutter pub get

# Regenerate iOS files
echo "🔧 Generating iOS build files..."
cd ios

# Remove old Podfile if it exists and let Flutter generate a fresh one
if [ -f Podfile ]; then
    rm Podfile
fi

cd ..

# Run pod install with repo update
echo "📦 Running CocoaPods install..."
cd ios
pod install --repo-update
cd ..

echo "✅ iOS build fix complete!"
echo ""
echo "Next steps:"
echo "1. In Xcode: Product > Scheme > Select 'Runner'"
echo "2. In Xcode: Product > Clean Build Folder (Cmd+Shift+K)"
echo "3. Run: flutter run"
