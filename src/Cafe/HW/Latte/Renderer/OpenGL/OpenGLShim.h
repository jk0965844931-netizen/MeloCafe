// Shim for desktop OpenGL calls to work with OpenGL ES 3.0
// This file is included conditionally for iOS builds

#pragma once

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE

#include "OpenGLCompat.h"
#include <vector>
#include <map>

namespace OpenGLCompat
{
    // ES 3.0 doesn't have glDrawElementsBaseVertex
    // We'll need to provide an alternative implementation
    // For now, just use regular glDrawElements (may not work correctly)
    inline void glDrawElementsBaseVertexWrapper(
        GLenum mode,
        GLsizei count,
        GLenum type,
        const void* indices,
        GLint basevertex)
    {
        // TODO: This is a workaround. For proper support, we need to:
        // 1. Either duplicate vertices in the VBO
        // 2. Or use a vertex shader to offset attributes
        // 3. Or use instanced rendering
        
        // For now, try without basevertex (may cause issues)
        glDrawElements(mode, count, type, indices);
    }

    // Define macro to automatically replace calls
    #define glDrawElementsBaseVertex glDrawElementsBaseVertexWrapper

    // ES 3.0 uses different texture rectangle handling
    // Desktop GL has GL_TEXTURE_RECTANGLE, ES 3.0 doesn't
    // We'll need to normalize texture coordinates

    // No glMapBufferRange with MAP_INVALIDATE_BUFFER_BIT
    // Use glBufferData with nullptr to invalidate
    
    // No glBindFragDataLocation (ES uses layout(location=...) in shader)
    inline void glBindFragDataLocationWrapper(GLuint program, GLuint colorNumber, const char* name)
    {
        // ES 3.0 doesn't support this - use layout in shader
        // This is a no-op, shader compilation will need to handle it
    }

    #define glBindFragDataLocation glBindFragDataLocationWrapper

    // No glBufferSubData with offset > 0 in some cases
    // Need to be careful with partial updates

} // namespace OpenGLCompat

#endif // TARGET_OS_IPHONE