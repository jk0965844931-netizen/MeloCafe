# iOS GUI Stub

Minimal placeholder GUI layer for iOS builds.

## Purpose

Cemu's main GUI uses wxWidgets, which doesn't support iOS. This stub provides
just enough to get the emulator building and running on iOS.

## Current State

This is a **non-functional stub**. It:
- ✅ Allows the project to compile on iOS
- ❌ Does NOT provide any actual UI
- ❌ Cannot render games
- ❌ Cannot accept user input

## What's Needed for Real iOS GUI

### Option 1: Dear ImGui + iOS Backend
- Pros:
  - Dear ImGui is already in the codebase (used for some overlays)
  - Lightweight and fast
  - Easy to implement touch controls
- Cons:
  - Not a full GUI framework
  - Limited UI widgets

### Option 2: SDL2 + Custom UI
- Pros:
  - SDL2 is already a dependency
  - Cross-platform
  - Good for game UI
- Cons:
  - No built-in widgets
  - All UI must be custom-built

### Option 3: Native UIKit Wrapper
- Pros:
  - Native iOS look and feel
  - Full iOS integration
  - Best performance
- Cons:
  - Complex C++/ObjC bridging
  - Requires iOS development experience
  - Most work

## Recommended Approach

For a first working version:

1. **Phase 1**: Get command-line/boot working
   - No UI, just boot games and show output
   - Verify JIT works
   - Test basic emulation

2. **Phase 2**: Dear ImGui overlay
   - Add simple ImGui overlay for basic controls
   - Show FPS, game info
   - Load/save states

3. **Phase 3**: Touch controller
   - Virtual on-screen controller
   - Touch gesture handling
   - MFi controller support

4. **Phase 4**: Full UI (optional)
   - Game library browser
   - Settings menu
   - Save management

## Development Notes

- iOS uses a different app lifecycle than desktop
- Main loop is handled by iOS, not a while() loop
- Touch events come through iOS gesture recognizers
- File access is sandboxed (use iOS file picker)

---

**Status**: Stub only - needs full implementation
**Last Updated**: 2026-05-22