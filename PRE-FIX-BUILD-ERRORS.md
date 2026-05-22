# 🔧 MeloCafe iOS — Pre-Fix Common Build Errors

---

## Common Build Errors & Fixes

This file contains fixes for the most likely build errors we anticipate.

---

## Error 1: OpenGL Functions Not Found

### Error Message
```
error: 'glDrawElementsBaseVertex' was not declared in this scope
error: 'glMapBufferRange' was not declared in this scope
```

### Root Cause
OpenGL ES 3.0 doesn't have all desktop OpenGL functions.

### Files to Fix
- `src/Cafe/HW/Latte/Renderer/OpenGL/*.cpp`
- `src/Cafe/HW/Latte/Renderer/OpenGL/*.h`

### Fix

Add to top of each GL file:
```cpp
#ifdef CEMU_PLATFORM_IOS
#include "OpenGLCompat.h"
#include "OpenGLShim.h"
#endif
```

Then replace specific function calls:
```cpp
// Desktop GL
glDrawElementsBaseVertex(...);

// iOS (ES 3.0)
#ifdef CEMU_PLATFORM_IOS
    glDrawElementsBaseVertexShim(...);
#else
    glDrawElementsBaseVertex(...);
#endif
```

### Status
- [ ] Documented
- [ ] Fix not yet applied

---

## Error 2: Shader Version Mismatch

### Error Message
```
error: GLSL version mismatch
error: #version 330 is not supported
```

### Root Cause
OpenGL ES uses GLSL 300 es, not 330.

### Files to Check
- `src/Cafe/HW/Latte/Renderer/OpenGL/*.frag`
- `src/Cafe/HW/Latte/Renderer/OpenGL/*.vert`

### Fix (Temporary)

Use preprocessor to switch versions:
```glsl
#ifdef GL_ES
#version 300 es
precision highp float;
#else
#version 330
#endif
```

### Fix (Long-term)

Create shader converter tool to transform GLSL 330 → 300 es automatically.

### Status
- [ ] Documented
- [ ] Fix not yet applied

---

## Error 3: Unknown CMake Variable

### Error Message
```
error: Unknown CMake variable "CMAKE_OSX_DEPLOYMENT_TARGET"
error: Unknown CMake variable "CMAKE_OSX_ARCHITECTURES"
```

### Root Cause
CMake variable not recognized in some configurations.

### Fix

Update CMakeLists.txt:
```cmake
if(IS_IOS)
    set(CMAKE_SYSTEM_NAME iOS)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "14.0" CACHE STRING "Minimum OS version")
    set(CMAKE_OSX_ARCHITECTURES "arm64" CACHE STRING "Architecture")
endif()
```

### Status
- [ ] Documented
- [ ] Partially implemented

---

## Error 4: Undefined Symbols (Dependencies)

### Error Message
```
Undefined symbol: _boost::...
Undefined symbol: _SDL_...
```

### Root Cause
Dependencies not built for iOS arm64.

### Files
- `dependencies/vcpkg/`
- CMakeLists.txt

### Fix

Ensure vcpkg builds iOS versions:
```bash
cd dependencies/vcpkg
./vcpkg install boost-system:arm64-ios
./vcpkg install boost-filesystem:arm64-ios
./vcpkg install sdl2:arm64-ios
```

Add to CMakeLists.txt:
```cmake
if(IS_IOS)
    find_package(Boost COMPONENTS system filesystem REQUIRED)
    find_package(SDL2 REQUIRED)
    target_link_libraries(Cemu PRIVATE
        Boost::system
        Boost::filesystem
        SDL2::SDL2
    )
endif()
```

### Status
- [ ] Documented
- [ ] Fix not yet applied

---

## Error 5: iOS-specific Headers Missing

### Error Message
```
error: 'UIKit/UIKit.h' file not found
error: 'Foundation/Foundation.h' file not found
```

### Root Cause
iOS headers not accessible or not included.

### Files to Fix
- `src/ios/*.cpp`
- `src/ios/*.h`

### Fix

Ensure iOS files have proper includes:
```cpp
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Metal/Metal.h>
```

Add to CMakeLists.txt:
```cmake
if(IS_IOS)
    target_include_directories(Cemu PRIVATE
        ${IOS_PLATFORM_HEADERS}
    )
endif()
```

### Status
- [ ] Documented
- [ ] Headers already created

---

## Error 6: wxWidgets Not Found (Expected!)

### Error Message
```
error: wx/wx.h file not found
```

### Root Cause
wxWidgets doesn't support iOS (intentional — we created GUI stub).

### Files
- `src/main.cpp`
- `CMakeLists.txt`

### Fix (Already Implemented!)

We've already bypassed this:
- Created `src/gui/iosgui/` stub
- Updated CMakeLists.txt to use iOS GUI
- wxWidgets only built for desktop platforms

### Verification

Check CMakeLists.txt:
```cmake
if(ENABLE_WXWIDGETS AND NOT IS_IOS)
    add_subdirectory(gui/wxgui)
endif()

if(IS_IOS)
    add_subdirectory(gui/iosgui)
endif()
```

### Status
- [ ] Documented
- [ ] ✅ Fixed in commit c81be82

---

## Error 7: JIT Entitlements Not Applied

### Error Message (Runtime)
```
Error: JIT compilation failed
Error: Dynamic code execution not allowed
```

### Root Cause
Entitlements not properly applied to IPA.

### Files
- `ios/entitlements.plist`
- `.github/workflows/build-ios.yml`

### Verification

Check entitlements.plist has:
```xml
<key>com.apple.security.cs.allow-jit</key>
<true/>
```

Check workflow has codesign step:
```yaml
codesign --force --deep --sign - \
  --entitlements ios/entitlements.plist \
  build-ios/MeloCafe.app
```

### Status
- [ ] Documented
- [ ] ✅ Implemented (needs device testing)

---

## Fix Priority

| Priority | Error | Status |
|----------|-------|--------|
| 🔴 Critical | OpenGL functions | Not applied |
| 🔴 Critical | Shader version | Not applied |
| 🟡 High | Dependencies | Not applied |
| 🟡 High | iOS headers | ✅ Complete |
| 🟢 Low | wxWidgets | ✅ Complete |
| 🟢 Low | JIT entitlements | ✅ Complete |

---

## Quick Fix Commands

When errors appear, use these commands to apply fixes:

### 1. Add OpenGL Compatibility Headers
```bash
# Find all GL .cpp and .h files
find src/Cafe/HW/Latte/Renderer/OpenGL -name "*.cpp" -o -name "*.h" | while read file; do
    # Add include at top if not present
    if ! grep -q "OpenGLCompat.h" "$file"; then
        sed -i '1i\
#ifdef CEMU_PLATFORM_IOS\
#include "OpenGLCompat.h"\
#include "OpenGLShim.h"\
#endif\
' "$file"
    fi
done
```

### 2. Update Shader Versions
```bash
# Find all shader files
find src/Cafe/HW/Latte/Renderer/OpenGL -name "*.frag" -o -name "*.vert" | while read file; do
    # Replace version directive
    sed -i 's/#version 330/#ifdef GL_ES\n#version 300 es\n#else\n#version 330\n#endif/' "$file"
done
```

---

## Next Steps

1. **Wait for Build Failure** (expected)
2. **Document Specific Error**
3. **Apply Relevant Fix**
4. **Push and Retry**
5. **Repeat Until Success**

---

## Documentation

- `KNOWN-ISSUES.md` — Known issues reference
- `BUILD-STATUS.md` — Build status tracking
- `PHASE2-BUILD-TESTING.md` — Build testing guide
- `docs/shader-es3-compatibility.md` — Shader guide

---

💚 **Ready for build monitoring and error fixing!**

**— Ken 💚**

---

*This file will be updated as errors are encountered and fixed.*