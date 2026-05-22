# MeloCafe iOS - TODO List

## ✅ Completed

- [x] Clone repository from fork
- [x] Create iOS toolchain file for CMake
- [x] Create entitlements.plist with JIT support
- [x] Create Info.plist for iOS app bundle
- [x] Create build-ios.sh script
- [x] Create README-IOS.md with instructions
- [x] Create GitHub Actions workflow for iOS builds
- [x] Modify CMakeLists.txt for iOS support

## 🚧 In Progress

- [ ] Test GitHub Actions iOS build
- [ ] Create iOS UI layer (replace wxWidgets)

## 📋 TODO (Next Steps)

### High Priority

1. **iOS UI Implementation**
   - wxWidgets won't work on iOS
   - Need to create a native iOS UI using UIKit or a cross-platform framework
   - Options:
     - Dear ImGui with iOS backend (easiest, already used for some UI)
     - SDL2 with custom UI
     - Flutter (but complex to integrate with C++)
     - Pure C++ UI library (nuklear, CEGUI, etc.)

2. **Game Controller Implementation**
   - Virtual on-screen controller
   - Touch controls mapping
   - Support for external MFi controllers
   - Controller vibration (haptic feedback)

3. **File System Access**
   - iOS sandbox file access
   - Game file browser
   - Save state management
   - Configuration file handling

4. **Graphics Backend**
   - Switch from OpenGL to OpenGL ES 3.0+
   - Metal backend (for better performance)
   - Shader conversion

### Medium Priority

5. **Audio Backend**
   - iOS audio output (AVAudioEngine)
   - Replace cubeb with iOS native audio

6. **Input Handling**
   - Touch gesture support
   - Multi-touch handling
   - Controller input mapping

7. **Performance Optimization**
   - JIT compilation tweaks for iOS
   - Memory management
   - Threading optimizations

### Low Priority

8. **Additional Features**
   - AirPlay support
   - External display support
   - iCloud save sync
   - Game controller mapping UI

9. **Documentation**
   - Build instructions for local macOS builds
   - Troubleshooting guide
   - Compatibility list

## 🧪 Testing Needed

- [ ] Build on GitHub Actions
- [ ] Test IPA installation on device
- [ ] Test JIT functionality with LiveContainer
- [ ] Test game loading and execution
- [ ] Performance testing on different iOS devices
- [ ] Touch control testing
- [ ] External controller testing

## 🐛 Known Issues

- wxWidgets GUI won't compile on iOS (needs replacement)
- Some dependencies may need iOS-specific builds
- OpenGL → OpenGL ES conversion needed
- File system sandboxing on iOS

## 💡 Technical Notes

### JIT on iOS
- LiveContainer provides JIT through undocumented API
- Entitlements file is required
- `com.apple.security.cs.allow-jit` is the key entitlement

### LiveContainer Compatibility
- Minimum iOS version: 14.0+
- Works best on A12+ devices
- 64-bit only (arm64)

### Performance Targets
- iPhone 12+: 30-60 FPS for most games
- iPhone 8-11: May struggle with demanding games
- iPad Pro: Best performance

## 📚 Resources

- [Cemu Source Code](https://github.com/cemu-project/Cemu)
- [LiveContainer](https://github.com/khanhduytran0/LiveContainer)
- [iOS OpenGL ES](https://developer.apple.com/library/archive/documentation/3DDrawing/Conceptual/OpenGLES_ProgrammingGuide/)
- [Metal for C++](https://developer.apple.com/metal/cpp/)

## 🤝 Contributions

This is a complex project. Help needed with:
- iOS development
- Graphics programming (OpenGL ES/Metal)
- UI/UX design
- Testing on various iOS devices

---

**Last Updated**: 2026-05-22
**Status**: Early development stage