# iOS Build Known Issues and Solutions

## Critical Blockers

### 1. wxWidgets GUI
**Status**: ✅ Fixed with stub
- Created `src/gui/iosgui/` minimal GUI
- Allows compilation but doesn't provide UI
- **Next**: Implement actual iOS UI (Dear ImGui or native)

### 2. Desktop OpenGL → OpenGL ES
**Status**: 🚧 In progress
- Created `OpenGLCompat.h` and `OpenGLShim.h`
- Major compatibility issues remain
- **Next**: Update all rendering code

## Expected Build Errors

### OpenGL Related
```
error: 'glDrawElementsBaseVertex' was not declared in this scope
error: 'GL_TEXTURE_RECTANGLE' was not declared
error: 'glBindFragDataLocation' was not declared
```

**Fix**: Use the shim headers created in:
- `src/Cafe/HW/Latte/Renderer/OpenGL/OpenGLCompat.h`
- `src/Cafe/HW/Latte/Renderer/OpenGL/OpenGLShim.h`

### Shader Compilation
```
error: #version must be 300 es for OpenGL ES 3.0
error: 'layout(location=0)' not supported
```

**Fix**: Update GLSL version and qualifier usage

### Missing Headers
```
fatal error: 'GL/glew.h' file not found
fatal error: 'X11/Xlib.h' file not found
```

**Fix**: Already handled in CMakeLists.txt (disabled for iOS)

## Dependency Issues

### Boost
Boost may need to be built for iOS arm64. Options:
1. Use vcpkg with iOS triplet
2. Build manually
3. Use pre-built iOS packages

### Other Libraries
- **libzip**: Should work with iOS SDK
- **pugixml**: Pure C++ headers, should work
- **RapidJSON**: Pure C++ headers, should work
- **fmt**: Pure C++ headers, should work

## Performance Issues (After Build Works)

### Memory Bandwidth
Mobile GPUs are bandwidth-limited:
- Use compressed textures
- Minimize texture reads
- Optimize shaders

### Tile-Based Rendering
iOS uses tile-based rendering (TBDR):
- Optimize for TBDR architecture
- Avoid overdraw
- Batch draw calls

### Shader Complexity
Mobile GPUs have weaker shaders:
- Simplify vertex shaders
- Optimize fragment shaders
- Use lower precision where possible

## Testing Checklist

### Phase 1: Basic Compilation
- [ ] Build succeeds on GitHub Actions
- [ ] IPA is generated
- [ ] No critical linker errors

### Phase 2: Basic Runtime
- [ ] App launches on iOS
- [ ] Doesn't crash immediately
- [ ] JIT is enabled (check with LiveContainer)

### Phase 3: Rendering
- [ ] OpenGL ES context created
- [ ] Basic rendering works
- [ ] Shaders compile

### Phase 4: Emulation
- [ ] Game files can be loaded
- [ ] Wii U code starts executing
- [ ] Basic game functions work

### Phase 5: Performance
- [ ] Playable framerates
- [ ] Acceptable memory usage
- [ ] Battery life reasonable

## Next Actions

1. **Monitor GitHub Actions build** - Check for actual errors
2. **Fix OpenGL issues** - Based on build log errors
3. **Update rendering code** - Add shim headers to OpenGL files
4. **Test on device** - Once IPA is available

## Quick Reference

- Build log: https://github.com/jk0965844931-netizen/MeloCafe/actions
- OpenGL ES docs: https://registry.khronos.org/OpenGL-Refpages/es3/
- iOS GL tips: https://developer.apple.com/documentation/opengles

---

**Last updated**: 2026-05-22
**Status**: Infrastructure complete, awaiting build feedback