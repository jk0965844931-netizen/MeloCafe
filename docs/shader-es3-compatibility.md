# Shader GLSL Version Compatibility (Desktop → ES 3.0)

## Overview

Cemu shaders are written for Desktop OpenGL (GLSL 330+ or 450), but iOS requires OpenGL ES 3.0 (GLSL 300 es).

## Key Differences

### Version Declaration

**Desktop GL:**
```glsl
#version 330 core
#version 450 core
```

**ES 3.0:**
```glsl
#version 300 es
precision mediump float;  // Required in ES
precision mediump int;
```

### Variable Qualifiers

**Desktop GL:**
```glsl
layout(location = 0) in vec3 position;
layout(location = 1) in vec3 color;
layout(location = 0) out vec4 fragColor;
```

**ES 3.0:**
```glsl
// layout(location) is supported in ES 3.0
layout(location = 0) in vec3 position;
layout(location = 1) in vec3 color;
layout(location = 0) out vec4 fragColor;

// BUT: Need precision qualifiers
precision highp float;
precision mediump int;
```

### Missing Features in ES 3.0

1. **No binding points** (in older ES versions)
2. **No compute shaders** (ES 3.1 has them, but we target 3.0)
3. **Limited shader stages** (only vertex, fragment, geometry)
4. **Different texture formats**
5. **No gl_FragDepth** (requires extension)

## Automatic Conversion Approach

### Phase 1: Preprocessor Macros

Create a header file that all shaders include:

```glsl
// shader_common.glsl
#ifdef TARGET_OS_IPHONE
    #define GLSL_VERSION "300 es"
    #define HAS_PRECISION 1
#else
    #define GLSL_VERSION "330 core"
    #define HAS_PRECISION 0
#endif

#if HAS_PRECISION
    precision highp float;
    precision mediump int;
#endif
```

### Phase 2: String Replacement

For critical differences, use C++ to modify shader source before compilation:

```cpp
std::string ConvertShaderForES(const std::string& source) {
    std::string result = source;
    
    // Replace version declaration
    result = std::regex_replace(result, 
        std::regex("#version \\d+"),
        "#version 300 es\nprecision highp float;");
    
    // Add precision if missing
    // ...
    
    return result;
}
```

### Phase 3: Manual Updates

For complex shaders, create ES-specific versions:

```
shader_vertex.glsl        # Desktop
shader_vertex_es3.glsl    # ES 3.0
```

## Specific Shader Changes Needed

### 1. Fragment Shader Depth

**Desktop:**
```glsl
void main() {
    gl_FragDepth = depthValue;
}
```

**ES 3.0:**
```glsl
#extension GL_EXT_frag_depth : enable
void main() {
    gl_FragDepthEXT = depthValue;
}
```

### 2. Integer Operations

**Desktop:**
```glsl
int x = 5;
```

**ES 3.0:**
```glsl
precision mediump int;
int x = 5;
```

### 3. Texture Functions

Some texture functions have different signatures in ES 3.0.

## Implementation Plan

### Step 1: Shader Conversion Tool

Create a C++ tool that:
1. Scans all shader files
2. Converts GLSL version
3. Adds precision qualifiers
4. Reports conversion warnings

### Step 2: Latte Shader Compiler Integration

Modify `LatteShaderGL.cpp` to:
1. Detect if building for ES 3.0
2. Apply automatic conversions
3. Log conversion details

### Step 3: Test Critical Shaders

Test conversion on:
- Basic vertex shaders
- Basic fragment shaders
- Texture sampling
- Color conversion

### Step 4: Handle Failure Cases

Some shaders may need manual fixes:
1. Log which ones fail
2. Create ES-specific versions
3. Update build system

## Testing Strategy

```bash
# Extract shaders from a game
# Convert them
# Verify they compile on ES 3.0

# Use online GLSL validator:
# https://www.khronos.org/opengles/sdk/tools/Reference-Compiler/
```

## Quick Reference

| Feature | Desktop GL 330 | ES 3.0 | Notes |
|---------|---------------|--------|-------|
| Vertex Shader | ✅ | ✅ | Compatible |
| Fragment Shader | ✅ | ✅ | Compatible |
| Geometry Shader | ✅ | ⚠️ | Limited support |
| Compute Shader | ✅ | ❌ | Not in ES 3.0 |
| Integer ops | ✅ | ✅ | Need precision |
| Texture 3D | ✅ | ✅ | Compatible |
| Texture Cube | ✅ | ✅ | Compatible |
| gl_FragDepth | ✅ | ⚠️ | Needs extension |

## Resources

- [OpenGL ES 3.0 Spec](https://www.khronos.org/opengles/3.0)
- [GLSL ES 3.0 Reference](https://www.khronos.org/opengles/sdk/docs/3.0/reference_card/GLSL_ES_3.0.pdf)
- [GLSL Sandbox](https://www.shadertoy.com/)

---

**Status**: Planning phase
**Priority**: High (required for rendering)
**Estimated effort**: 1-2 weeks