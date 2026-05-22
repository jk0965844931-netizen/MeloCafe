#!/bin/bash

# Fix 1: Add OpenGL Compatibility Headers to all GL files
# This fixes "OpenGL functions not found" errors

echo "🔧 Fixing OpenGL compatibility headers..."

GL_DIR="src/Cafe/HW/Latte/Renderer/OpenGL"

# Find all .cpp and .h files in GL directory
if [ -d "$GL_DIR" ]; then
    find "$GL_DIR" -name "*.cpp" -o -name "*.h" | while read file; do
        echo "  Processing: $file"

        # Check if OpenGLCompat.h is already included
        if ! grep -q "OpenGLCompat.h" "$file"; then
            # Get the first line (usually #include or blank)
            first_line=$(head -n 1 "$file")

            # Create temp file with new includes
            temp_file=$(mktemp)

            # Write the iOS-specific includes first
            cat > "$temp_file" << 'EOF'
#ifdef CEMU_PLATFORM_IOS
#include "OpenGLCompat.h"
#include "OpenGLShim.h"
#endif
EOF

            # Append the rest of the file
            tail -n +1 "$file" >> "$temp_file"

            # Replace original file
            mv "$temp_file" "$file"

            echo "    ✓ Added OpenGL compatibility includes"
        else
            echo "    - Already has includes, skipping"
        fi
    done
else
    echo "  ⚠️  OpenGL directory not found: $GL_DIR"
    echo "  Skipping OpenGL header fixes..."
fi

echo "✅ OpenGL compatibility headers added (or already present)!"