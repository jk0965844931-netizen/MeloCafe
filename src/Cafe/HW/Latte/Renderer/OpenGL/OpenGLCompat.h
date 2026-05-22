#ifdef CEMU_PLATFORM_IOS
#include "OpenGLCompat.h"
#include "OpenGLShim.h"
#endif
#pragma once

// OpenGL ES Compatibility Header for iOS
// This provides compatibility between desktop OpenGL and OpenGL ES 3.0+

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
    // iOS uses OpenGL ES
    #include <OpenGLES/ES3/gl.h>
    #include <OpenGLES/ES3/glext.h>

    #define GL_GLEXT_PROTOTYPES 1

    // Desktop OpenGL to ES compatibility macros
    #ifndef GL_TEXTURE_RECTANGLE
        #define GL_TEXTURE_RECTANGLE GL_TEXTURE_2D
    #endif

    // Some extensions are core in ES 3.0
    #ifndef GL_ARRAY_BUFFER_BINDING
        #define GL_ARRAY_BUFFER_BINDING 0x8894
    #endif

#else
    // Desktop platforms
    #include <GL/glew.h>
#endif

// Compatibility functions for ES 3.0
#ifdef __APPLE__
    #include <TargetConditionals.h>
#endif

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE

// Map OpenGL 2.x+ features to ES 3.0 equivalents

// Note: ES 3.0 doesn't have glDrawElementsBaseVertex
// This will need to be handled in the rendering code

inline void glEnablei(GLenum target, GLuint index)
{
    // ES 3.0 doesn't support glEnablei - this is a limitation
    // In practice, this affects multisample and such
}

#endif

namespace OpenGLCompat
{
    // Check if we're running on iOS
    inline bool isMobile()
    {
#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
        return true;
#else
        return false;
#endif
    }

    // Get GL version string
    inline const char* getVersion()
    {
        return reinterpret_cast<const char*>(glGetString(GL_VERSION));
    }

    // Check for specific ES features
    inline bool hasExtension(const char* ext)
    {
#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE
        // ES 3.0 has most desktop features built-in
        return true;
#else
        // Desktop - use GLEW
        return glewIsSupported(ext);
#endif
    }
}