# Manual Step-by-Step: Local macOS iOS Build

This guide shows how to build MeloCafe for iOS locally on a Mac, without waiting for GitHub Actions.

## Prerequisites

1. **Mac with Apple Silicon (M1/M2) or Intel**
2. **Xcode 15.2 or later** (from App Store)
3. **CMake 3.21+**
4. **Ninja build system**
5. **Command Line Tools for Xcode**

## Installation

```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install cmake ninja nasm

# Set Xcode path
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Verify installation
xcodebuild -version
cmake --version
ninja --version
```

## Build Steps

### 1. Clone Repository

```bash
cd ~/Desktop
git clone https://github.com/jk0965844931-netizen/MeloCafe.git
cd MeloCafe

# Initialize submodules if needed
git submodule update --init --recursive
```

### 2. Configure for iOS

```bash
# Create build directory
mkdir -p build-ios
cd build-ios

# Configure CMake for iOS arm64
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=../ios.toolchain.cmake \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES=arm64 \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=14.0 \
    -G Ninja
```

### 3. Build

```bash
# Build with all CPU cores
cmake --build . --config Release -j$(sysctl -n hw.ncpu)
```

**Expected Errors:**
- `error: 'glDrawElementsBaseVertex' was not declared` → OpenGL ES compatibility needed
- `error: 'GL_TEXTURE_RECTANGLE' was not declared` → Use ES 3.0 texture formats
- Linking errors → Dependencies missing

### 4. Fix Common Errors

#### OpenGL Headers Issue
```bash
# Ensure OpenGLCompat.h is included
# Edit OpenGLRenderer.h to include:
# #include "OpenGLCompat.h"
```

#### CemuCore Linking
```bash
# If iOS GUI fails to link, add to src/gui/iosgui/CMakeLists.txt:
# target_link_libraries(CemuIOSGui PUBLIC CemuCore)
```

#### Boost Missing
```bash
# Build Boost manually for iOS
cd dependencies
git clone --recursive https://github.com/boostorg/boost.git
cd boost
./bootstrap.sh --with-libraries=filesystem,system,program_options,nowide
./b2 toolset=clang cxxflags="-arch arm64" linkflags="-arch arm64" install
```

### 5. Create App Bundle

```bash
# If build succeeds, create app bundle
APP_BUNDLE="MeloCafe.app"
rm -rf "$APP_BUNDLE"
mkdir -p "$APP_BUNDLE"

# Copy executable
cp bin/Cemu_release "$APP_BUNDLE/MeloCafe" 2>/dev/null || \
cp bin/Cemu "$APP_BUNDLE/MeloCafe" 2>/dev/null || \
echo "Error: Executable not found in bin/"

chmod +x "$APP_BUNDLE/MeloCafe"

# Copy Info.plist
cp ../ios/Info.plist "$APP_BUNDLE/"

# Create resource directories
mkdir -p "$APP_BUNDLE/Resources"
mkdir -p "$APP_BUNDLE/lib"
```

### 6. Sign with Entitlements

```bash
# Apply entitlements (for JIT)
codesign --force --deep --sign - \
    --entitlements ../ios/entitlements.plist \
    --timestamp=none \
    MeloCafe.app
```

### 7. Create IPA

```bash
mkdir -p Payload
cp -r MeloCafe.app Payload/
zip -r MeloCafe-unsigned.ipa Payload/
rm -rf Payload

echo "IPA created: MeloCafe-unsigned.ipa"
ls -lh MeloCafe-unsigned.ipa
```

## Transfer to iPhone

### Option 1: AirDrop (simplest)
1. Connect Mac and iPhone to same Wi-Fi
2. Right-click MeloCafe-unsigned.ipa
3. Share → AirDrop → Your iPhone

### Option 2: Safari
```bash
# Serve file via HTTP
cd ~/Desktop/MeloCafe/build-ios
python3 -m http.server 8000

# On iPhone, visit:
# http://YOUR_MAC_IP:8000/MeloCafe-unsigned.ipa
```

### Option 3: File App
1. Copy IPA to iCloud Drive
2. Open Files app on iPhone
3. Download IPA

## Install with LiveContainer

1. **Install LiveContainer**:
   - Add AltStore repo: `https://altstore.io/altstore.json`
   - Install LiveContainer

2. **Import IPA**:
   - Open LiveContainer
   - Tap "+" button
   - Select MeloCafe-unsigned.ipa
   - Wait for installation

3. **Enable JIT**:
   - LiveContainer automatically enables JIT
   - No additional steps needed

## Troubleshooting

### "Command line tools not installed"
```bash
xcode-select --install
```

### "CMake not found"
```bash
brew install cmake
```

### "Ninja not found"
```bash
brew install ninja
```

### Build fails at linking
- Check error messages carefully
- Most likely missing dependencies
- Check KNOWN-ISSUES.md

### App crashes on launch
- Check iOS console logs (Xcode → Window → Devices and Simulators)
- Look for missing frameworks or libraries
- Verify entitlements are applied correctly

### JIT not working
- Ensure LiveContainer is installed
- Check entitlements are correct
- Try reinstalling IPA

## Quick Build Script

Save as `quick-build.sh`:

```bash
#!/bin/bash

set -e

echo "Building MeloCafe for iOS..."

cd "$(dirname "$0")"

mkdir -p build-ios
cd build-ios

cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=../ios.toolchain.cmake \
    -DCMAKE_SYSTEM_NAME=iOS \
    -DCMAKE_OSX_ARCHITECTURES=arm64 \
    -DCMAKE_OSX_DEPLOYMENT_TARGET=14.0 \
    -G Ninja

cmake --build . --config Release -j$(sysctl -n hw.ncpu)

echo "Build complete!"
```

Make executable:
```bash
chmod +x quick-build.sh
./quick-build.sh
```

## Next Steps After Success

1. **Test basic functionality**
   - Does app launch?
   - Does JIT work?
   - Can you navigate UI (if any)?

2. **Try loading a game**
   - Copy WUD/WUX file to app documents
   - Try to load in emulator
   - Check for rendering output

3. **Report issues**
   - Document what works
   - Document what fails
   - Check GitHub Actions for comparison

---

**Last updated**: 2026-05-22
**Build target**: iOS arm64
**Minimum iOS**: 14.0