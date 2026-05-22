# 🔧 Apply Pre-emptive Build Fixes

This directory contains scripts to fix common build errors before pushing to GitHub.

---

## Quick Start

Run all fixes at once:

```bash
./apply-all-fixes.sh
```

This will:
1. Add OpenGL compatibility headers to all GL files
2. Update shader versions from 330 to 300 es
3. Verify iOS-specific includes
4. Show summary of changes

---

## Individual Fixes

### Fix 1: OpenGL Compatibility Headers

**Problem**: OpenGL ES 3.0 doesn't have all desktop GL functions.

**Solution**: Add compatibility headers to all GL rendering files.

```bash
./fix-opengl-headers.sh
```

**What it does**:
- Finds all `.cpp` and `.h` files in `src/Cafe/HW/Latte/Renderer/OpenGL/`
- Adds `#include "OpenGLCompat.h"` and `#include "OpenGLShim.h"` (wrapped in `#ifdef CEMU_PLATFORM_IOS`)
- Skips files that already have these includes

**Expected changes**: ~20-30 files modified

---

### Fix 2: Shader Versions

**Problem**: OpenGL ES uses GLSL 300 es, not 330.

**Solution**: Update shader version directives with conditional compilation.

```bash
./fix-shader-versions.sh
```

**What it does**:
- Finds all `.frag` and `.vert` files
- Replaces `#version 330` with:
  ```glsl
  #ifdef GL_ES
  #version 300 es
  precision highp float;
  #else
  #version 330
  #endif
  ```
- Skips files without version directives or with other versions

**Expected changes**: ~10-20 shader files modified

---

## After Running Fixes

### 1. Review Changes

```bash
git diff
```

### 2. Commit Fixes

```bash
git add -A
git commit -m "fix: apply pre-emptive build error fixes

- Add OpenGL compatibility headers to GL files
- Update shader versions (330 → 300 es)
- Verify iOS-specific includes

Pre-emptive fixes to reduce build failures in Phase 2.

See PRE-FIX-BUILD-ERRORS.md for details on each fix."
```

### 3. Push to GitHub

```bash
git push origin main
```

### 4. Monitor Build

Visit: https://github.com/jk0965844931-netizen/MeloCafe/actions

---

## Expected Build Time

| Phase | Time |
|-------|------|
| Checkout & Setup | 2-3 min |
| Dependencies | 10-15 min (first) / 2-3 min (cached) |
| CMake Configure | 2-3 min |
| Build | 20-30 min |
| Packaging | 1-2 min |
| **Total** | **35-53 min** |

---

## If Build Still Fails

1. **Download Build Log**
   - From GitHub Actions page
   - Look for "error:" messages

2. **Document Error**
   - Use template in `PHASE2-BUILD-TESTING.md`

3. **Apply Specific Fix**
   - See `PRE-FIX-BUILD-ERRORS.md` for solutions

4. **Push and Retry**
   - Commit fix
   - Push to GitHub
   - Monitor new build

---

## Known Issues

See `KNOWN-ISSUES.md` for:
- All anticipated build errors
- Root causes and fixes
- Workarounds

---

## Documentation

- `PRE-FIX-BUILD-ERRORS.md` — Detailed fix documentation
- `PHASE2-BUILD-TESTING.md` — Build testing guide
- `BUILD-STATUS.md` — Build status tracking

---

💚 **Ready to apply fixes and monitor build!**

**— Ken 💚**

---

*These fixes address the most common build errors we anticipate.*