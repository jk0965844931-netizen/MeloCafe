# MeloCafe iOS Build Instructions

## Goal
Build MeloCafe as a working IPA with JIT support that runs smoothly on iPhone via LiveContainer.

## Current State
- ✅ Repository cloned
- ✅ Base Cemu codebase (C++/C, 89.1% C++)
- ✅ GitHub Actions workflow for unsigned IPA exists (but incomplete)
- ❌ No Xcode project exists
- ❌ No iOS-specific build configuration
- ❌ No JIT entitlements configured

## What's Needed

### 1. iOS Project Setup
- Create Xcode project or use CMake with iOS toolchain
- Target: iOS arm64 (iPhone)
- Minimum iOS version: iOS 14+ (for LiveContainer compatibility)

### 2. JIT Configuration
For JIT to work on iOS (non-jailbroken), we need:
- Proper entitlements file with `com.apple.security.cs.allow-jit`
- LiveContainer (which provides JIT environment)
- Dynamic code execution enabled

### 3. Dependencies for iOS
Many dependencies will need iOS-specific versions:
- SDL2 (iOS framework)
- Boost (needs iOS build)
- Other libraries (need iOS-friendly versions)

### 4. Build System Options

**Option A: Use GitHub Actions (Recommended)**
- Pros: Uses macOS runners with full Xcode
- Cons: Push to GitHub required each build

**Option B: Local macOS Build**
- Requires: Mac with Xcode
- More control but requires local setup

**Option C: Cross-compile from Linux**
- Complex, requires iOS SDK and toolchain
- Not recommended for this project

## Recommended Approach

1. **Create iOS-specific CMake configuration**
   - iOS toolchain file
   - iOS-specific dependencies
   - Entitlements for JIT

2. **Set up LiveContainer compatibility**
   - Bundle structure
   - Dynamic library loading
   - JIT runtime configuration

3. **Build workflow**
   - Use GitHub Actions for initial builds
   - Create local build script for Mac users

## Next Steps

1. Examine source code for platform-specific code
2. Create iOS toolchain file for CMake
3. Set up entitlements for JIT
4. Create build script
5. Test with LiveContainer