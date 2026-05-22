# OpenGL ES Compatibility for iOS

## Problem

Cemu is written for desktop OpenGL (4.x), but iOS uses OpenGL ES 3.0+. The APIs are similar but not identical.

## Key Differences

### Missing/Changed in ES 3.0

1. **No glDrawElementsBaseVertex** - Used for efficient vertex reuse
2. **No glBegin/glEnd** - Modern GL anyway, but some code might use it
3. **No immediate mode** - Must use VBOs/VAOs everywhere
4. **Different texture formats** - Some compressed formats differ
5. **No glTexImage2D with some format combos**

### Available in ES 3.0

- ✅ Vertex Array Objects (VAOs)
- ✅ Vertex Buffer Objects (VBOs)
- ✅ Fragment/Vertex shaders
- ✅ Framebuffer objects (FBOs)
- ✅ Multiple render targets (MRT) - limited
- ✅ Instanced rendering
- ✅ Transform feedback - partial

## Approach

### Phase 1: Compatibility Layer
- Create `OpenGLCompat.h` to bridge differences
- Map desktop GL calls to ES equivalents where possible
- Stub out unsupported features (will degrade performance)

### Phase 2: Rendering Code Updates
- Modify Cafe rendering code to use ES-compatible calls
- Replace `glDrawElementsBaseVertex` with workaround
- Update texture format handling

### Phase 3: Optimization
- Optimize for mobile GPU architecture
- Reduce shader complexity
- Implement GPU-level optimizations for ARM GPUs

## Specific Changes Needed

### Vertex Drawing

Desktop:
```cpp
glDrawElementsBaseVertex(GL_TRIANGLES, count, GL_UNSIGNED_INT, nullptr, baseVertex);
```

ES 3.0:
```cpp
// Option A: Use index buffer offset
glDrawElements(GL_TRIANGLES, count, GL_UNSIGNED_INT, (void*)(baseVertex * sizeof(GLuint)));

// Option B: Duplicate vertices in VBO (memory heavy but works)
```

### Texture Formats

Desktop GL supports many texture formats natively. ES 3.0 is more limited:
- Some compressed formats need conversion
- Some internal formats need alternatives

### Shader Code

GLSL versions differ:
- Desktop: `#version 330 core` or higher
- ES 3.0: `#version 300 es`

Need to:
1. Replace version declarations
2. Update `in`/`out` to `attribute`/`varying` (older GLSL)
3. Update precision qualifiers (ES requires them)

## Performance Considerations

Mobile GPUs (PowerVR, Mali, Adreno) are different from desktop GPUs:

1. **Tile-based rendering** - Better for some patterns, worse for others
2. **Bandwidth limited** - Need to minimize texture reads
3. **Shader complexity** - Keep shaders simple
4. **Overdraw** - Avoid excessive overdraw

## Testing Strategy

1. **Start with simple games** - 2D games, indie games
2. **Gradually test more demanding games** - 3D, AAA
3. **Profile performance** - Identify bottlenecks
4. **Optimize hot paths** - Focus on rendering code

---

**Status**: Compatibility layer created, rendering code needs updates
**Priority**: High (required for iOS builds to work)
**Estimated effort**: 2-3 weeks for basic compatibility