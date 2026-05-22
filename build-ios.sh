#!/bin/bash

# MeloCafe iOS Build Script
# This script builds MeloCafe for iOS with JIT support for LiveContainer

set -e

echo "🍎 MeloCafe iOS Build Script"
echo "================================"

# Configuration
BUILD_TYPE="${BUILD_TYPE:-Release}"
IOS_DEPLOYMENT_TARGET="${IOS_DEPLOYMENT_TARGET:-14.0}"
BUILD_DIR="build-ios"
INSTALL_DIR="build-ios/install"
APP_NAME="MeloCafe"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}Error: This script must be run on macOS${NC}"
    echo "Use GitHub Actions or a Mac with Xcode to build for iOS"
    exit 1
fi

# Check for Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo -e "${RED}Error: Xcode not found${NC}"
    echo "Install Xcode from the Mac App Store"
    exit 1
fi

# Show Xcode version
echo -e "${GREEN}Xcode version:${NC}"
xcodebuild -version

# Select Xcode
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Clean build directory
echo -e "\n${YELLOW}Cleaning build directory...${NC}"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Configure CMake for iOS
echo -e "\n${GREEN}Configuring CMake for iOS...${NC}"
cmake -S . -B "$BUILD_DIR" \
    -DCMAKE_BUILD_TYPE="$BUILD_TYPE" \
    -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES=arm64 \
    -DCMAKE_OSX_DEPLOYMENT_TARGET="$IOS_DEPLOYMENT_TARGET" \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DCMAKE_C_FLAGS="-fvisibility=hidden" \
    -DCMAKE_CXX_FLAGS="-fvisibility=hidden -fvisibility-inlines-hidden" \
    -G Ninja

# Build
echo -e "\n${GREEN}Building MeloCafe...${NC}"
cmake --build "$BUILD_DIR" --config "$BUILD_TYPE" -j$(sysctl -n hw.ncpu)

# Create app bundle structure
echo -e "\n${YELLOW}Creating iOS app bundle...${NC}"
APP_BUNDLE="$BUILD_DIR/${APP_NAME}.app"
rm -rf "$APP_BUNDLE"
mkdir -p "$APP_BUNDLE"

# Copy executable
if [ -f "$BUILD_DIR/bin/Cemu_release" ]; then
    cp "$BUILD_DIR/bin/Cemu_release" "$APP_BUNDLE/$APP_NAME"
else
    echo -e "${RED}Error: Executable not found${NC}"
    exit 1
fi

chmod +x "$APP_BUNDLE/$APP_NAME"

# Copy Info.plist
cp ios/Info.plist "$APP_BUNDLE/"

# Create resource directories
mkdir -p "$APP_BUNDLE/Resources"
mkdir -p "$APP_BUNDLE/lib"

# Copy dependencies if they exist
echo -e "\n${YELLOW}Copying dependencies...${NC}"
# This is a placeholder - you may need to copy SDL2 and other frameworks
# copy_frameworks "$BUILD_DIR" "$APP_BUNDLE"

# Create IPA
echo -e "\n${GREEN}Creating IPA...${NC}"
IPA_DIR="$BUILD_DIR/ipa"
rm -rf "$IPA_DIR"
mkdir -p "$IPA_DIR/Payload"
cp -r "$APP_BUNDLE" "$IPA_DIR/Payload/"

cd "$IPA_DIR"
zip -r "../${APP_NAME}.ipa" Payload/
cd -

echo -e "\n${GREEN}✓ Build complete!${NC}"
echo "IPA location: $BUILD_DIR/${APP_NAME}.ipa"
echo ""
echo "To install on iPhone with LiveContainer:"
echo "1. Copy the IPA to your iPhone"
echo "2. Open LiveContainer"
echo "3. Import the IPA"
echo "4. JIT should be enabled automatically"