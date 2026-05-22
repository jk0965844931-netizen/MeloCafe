# MeloCafe iOS - Wii U Emulator for iPhone

## 📱 About

MeloCafe is a port of Cemu (Wii U emulator) for iOS, optimized to run smoothly on iPhone with JIT support via LiveContainer.

## ⚡ Features

- **JIT Support**: Full Just-In-Time compilation for performance
- **LiveContainer Compatible**: Install and run without jailbreak
- **Touch Controls**: On-screen game controls
- **Save States**: Save and load game progress
- **OpenGL ES 3**: Hardware-accelerated graphics

## 🏗️ Building

### Prerequisites

- macOS with Xcode 14+
- CMake 3.21+
- Ninja build system

### Quick Build (macOS)

```bash
# Clone the repository
git clone --recursive https://github.com/jk0965844931-netizen/MeloCafe.git
cd MeloCafe

# Build for iOS
./build-ios.sh
```

The IPA will be created at `build-ios/MeloCafe.ipa`.

### GitHub Actions Build

Push to `main` branch to trigger automatic build. The unsigned IPA will be available as a download artifact.

## 📲 Installation

### Method 1: LiveContainer (Recommended)

1. Install LiveContainer from [AltStore](https://altstore.io/) or sideload with Sideloadly
2. Download MeloCafe.ipa
3. Open LiveContainer
4. Import the IPA file
5. Launch and play!

### Method 2: TrollStore

If your device supports TrollStore:
1. Download MeloCafe.ipa
2. Use TrollHelper to install TrollStore
3. Open TrollStore and install MeloCafe.ipa

### Method 3: AltStore / Sideloadly

1. Install AltStore on your iOS device
2. Download MeloCafe.ipa
3. Open the IPA file with AltStore
4. Sign with your Apple ID
5. Launch and refresh every 7 days

## ⚙️ Configuration

### JIT Support

JIT is automatically enabled when running under LiveContainer. No additional setup required.

### Game Files

1. Create a `games` folder on your iPhone (Files app)
2. Copy your Wii U game files (WUD/WUX) there
3. In MeloCafe, navigate to the folder and load games

### Controls

- **Virtual Controller**: Touch-enabled gamepad on screen
- **External Controllers**: MFi controllers supported
- **Customization**: Map buttons in settings

## 🎮 Compatibility

Best performance on:
- iPhone 12 and newer
- iPad Pro (M1 and later)
- iOS 14.0+

Minimum requirements:
- iPhone 8 or newer
- 3GB RAM
- iOS 14.0+

## 🐛 Troubleshooting

### App crashes on launch

- Ensure you're using iOS 14.0 or later
- Check if JIT is enabled in LiveContainer
- Try reinstalling the IPA

### Poor performance

- Enable "Performance Mode" in settings
- Close background apps
- Reduce resolution in graphics settings

### Games not loading

- Verify your game files are not corrupted
- Ensure you have enough storage space
- Try using compressed WUX format instead of WUD

## 📝 License

MeloCafe is licensed under Mozilla Public License 2.0.

## 🙏 Credits

- [Cemu Project](https://github.com/cemu-project/Cemu) - Original Wii U emulator
- [stossy11](https://github.com/stossy11/MeloCafe) - Initial iOS fork
- LiveContainer team - JIT support without jailbreak

## 📧 Support

- Issues: [GitHub Issues](https://github.com/jk0965844931-netizen/MeloCafe/issues)
- Discord: [Cemu Discord](https://discord.gg/5psYsup)

---

**Note**: This is a work-in-progress project. Performance and compatibility will improve over time.