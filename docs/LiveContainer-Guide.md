# LiveContainer Integration Guide

## What is LiveContainer?

LiveContainer is an iOS app that allows you to run unsigned IPAs with JIT (Just-In-Time) compilation enabled, without jailbreaking. It's essential for emulators like MeloCafe that need dynamic code execution.

## Prerequisites

1. **iPhone with iOS 14.0+**
2. **AltStore** or **Sideloadly** (to install LiveContainer)
3. **MeloCafe unsigned IPA**

## Installation

### Step 1: Install AltStore

1. On your Mac, download AltServer from https://altstore.io/
2. Install AltServer
3. On iPhone, install AltStore from https://altstore.io/altstore.json
4. Pair your iPhone with AltServer

### Step 2: Install LiveContainer

1. On iPhone, open AltStore
2. Tap "Browse" tab
3. Search for "LiveContainer"
4. Tap "Install" next to LiveContainer
5. Wait for installation (requires Apple ID sign-in)

### Step 3: Install MeloCafe

#### Option A: AirDrop (Recommended)
1. Copy MeloCafe-unsigned.ipa to your Mac
2. Right-click → Share → AirDrop → Your iPhone
3. On iPhone, tap "Open in LiveContainer"

#### Option B: Files App
1. Upload MeloCafe-unsigned.ipa to iCloud Drive or Files app
2. Open LiveContainer on iPhone
3. Tap "+" → "Import from Files"
4. Select MeloCafe-unsigned.ipa

#### Option C: Direct Download
1. Host MeloCafe-unsigned.ipa on a web server
2. Open Safari on iPhone
3. Download the IPA
4. Choose "Open in LiveContainer"

## Configuration

### Enabling JIT

LiveContainer automatically enables JIT for installed apps. No manual configuration needed.

**Verification:**
- Launch MeloCafe
- Check if JIT is working (should see JIT-related logs in console)
- If emulation is slow, JIT may not be enabled

### Game File Location

MeloCafe needs access to game files. On iOS with sandboxing:

```
/var/mobile/Containers/Data/Application/[UUID]/Documents/
```

**How to access:**
1. Connect iPhone to Mac
2. Open Finder → iPhone → Files
3. Navigate to MeloCafe → Documents
4. Copy your game files there

**File formats supported:**
- WUD (raw Wii U disc image)
- WUX (compressed disc image)
- WUA (Wii U Archive)

### Controller Setup

#### Touch Controls (In-App)
1. Launch MeloCafe
2. Go to Settings → Input
3. Enable "Virtual Controller"
4. Customize button positions

#### External Controllers
**MFi Certified Controllers:**
- DualShock 4 (PS4)
- Xbox One Controller
- Xbox Series X|S Controller
- Nintendo Switch Pro Controller (with adapter)

**Setup:**
1. Connect controller via Bluetooth
2. Open LiveContainer → MeloCafe
3. Go to Settings → Input → "Detect Controllers"
4. Press any button on controller
5. Map buttons as needed

## Troubleshooting

### App Won't Launch

**Problem**: MeloCafe crashes immediately

**Solutions**:
1. Ensure JIT is enabled (LiveContainer should handle this)
2. Check iOS version (14.0+ required)
3. Try reinstalling IPA
4. Check Xcode console for crash logs:
   ```
   Xcode → Window → Devices and Simulators → View Device Logs
   ```

### JIT Not Working

**Problem**: Emulation is very slow

**Solutions**:
1. Verify LiveContainer is installed and working
2. Check entitlements in IPA
3. Try restarting LiveContainer
4. Test with a simple homebrew first

### Game Files Not Loading

**Problem**: Can't see or load game files

**Solutions**:
1. Verify files are in Documents folder
2. Check file format (WUD/WUX supported)
3. Verify files aren't corrupted
4. Try a different game

### Touch Controls Not Responding

**Problem**: Virtual controller doesn't work

**Solutions**:
1. Enable virtual controller in settings
2. Restart MeloCafe
3. Check if screen is in portrait mode (switch to landscape)

### External Controller Not Detected

**Problem**: Controller not connecting

**Solutions**:
1. Ensure controller is in pairing mode
2. Unpair and re-pair controller with iPhone
3. Check controller battery
4. Try a different controller

### Storage Full

**Problem**: No space for games

**Solutions**:
1. Check iPhone storage (Settings → General → iPhone Storage)
2. Delete unused apps
3. Move game files to iCloud (not recommended for emulation)

## Performance Tips

### For Better Performance:

1. **Use iPhone 12 or newer**
   - A12+ Bionic chip for better JIT performance
   - More RAM for game data

2. **Close background apps**
   - Free up memory and CPU

3. **Use compressed formats**
   - WUX instead of WUD saves space
   - Slightly faster load times

4. **Lower graphics settings**
   - Reduce resolution
   - Disable shadows
   - Lower texture quality

5. **Enable "Performance Mode"**
   - Settings → Graphics → Performance Mode

### To Save Battery:

1. **Lower frame rate cap**
   - Settings → Graphics → Frame Rate Limit → 30 FPS

2. **Reduce screen brightness**

3. **Use Airplane Mode**
   - Reduces background activity

## Updates

### Updating MeloCafe

When a new version is available:

1. Download new IPA from GitHub Releases
2. Open LiveContainer → MeloCafe
3. Tap "Delete" (this keeps your saves)
4. Import new IPA
5. Your saves should be preserved

### Updating LiveContainer

1. Open AltStore → My Apps
2. Find LiveContainer
3. Tap "Update"
4. Re-sign with your Apple ID

## Advanced Configuration

### Custom Game Paths

If you want to store games elsewhere:

```ini
# In MeloCafe settings file
GamePaths=/path/to/your/games
```

### Shader Cache

MeloCafe compiles shaders on first run. This can take a while:

**Location**: Documents/shaderCache

**To clear** (fixes graphics glitches):
1. Close MeloCafe
2. Delete shaderCache folder
3. Relaunch MeloCafe
4. Shaders will recompile

### Save States

**Location**: Documents/saves/

**Backup**:
1. Connect iPhone to Mac
2. Navigate to MeloCafe Documents
3. Copy saves folder to Mac

**Restore**:
1. Copy saves folder back to MeloCafe Documents
2. Relaunch MeloCafe

## Compatibility

### Known Working Devices:
- ✅ iPhone 12, 12 Pro, 12 Pro Max, 12 mini
- ✅ iPhone 13, 13 Pro, 13 Pro Max, 13 mini
- ✅ iPhone 14, 14 Pro, 14 Pro Max, 14 Plus
- ✅ iPhone 15, 15 Pro, 15 Pro Max, 15 Plus
- ✅ iPad Pro (M1/M2)
- ✅ iPad Air (M1/M2)

### Minimum Requirements:
- iPhone 8 or newer
- 3GB RAM
- iOS 14.0+

### Not Recommended:
- ❌ iPhone 7 and older (too slow)
- ❌ iPad mini 4 or older (limited RAM)
- ❌ iPod Touch (any generation)

## Resources

- [LiveContainer GitHub](https://github.com/khanhduytran0/LiveContainer)
- [AltStore](https://altstore.io/)
- [Cemu Compatibility List](https://wiki.cemu.info/wiki/Main_Page)

---

**Last updated**: 2026-05-22
**LiveContainer version**: Latest
**Tested on**: iOS 17.4