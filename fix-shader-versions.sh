#!/bin/bash

# Fix 2: Update Shader Versions from 330 to 300 es
# This fixes "GLSL version mismatch" errors

echo "🔧 Fixing shader versions..."

GL_DIR="src/Cafe/HW/Latte/Renderer/OpenGL"

# Find all .frag and .vert files
if [ -d "$GL_DIR" ]; then
    find "$GL_DIR" -name "*.frag" -o -name "*.vert" | while read file; do
        echo "  Processing: $file"

        # Check if it has a version directive
        if grep -q "#version" "$file"; then
            # Create temp file
            temp_file=$(mktemp)

            # Process the file line by line
            in_version=false
            while IFS= read -r line; do
                if [[ "$line" =~ ^#version[[:space:]]+330 ]]; then
                    # Replace #version 330 with conditional version
                    echo "#ifdef GL_ES" >> "$temp_file"
                    echo "#version 300 es" >> "$temp_file"
                    echo "precision highp float;" >> "$temp_file"
                    echo "#else" >> "$temp_file"
                    echo "#version 330" >> "$temp_file"
                    echo "#endif" >> "$temp_file"
                    echo "    ✓ Updated version directive"
                    in_version=true
                elif [[ "$line" =~ ^#version[[:space:]]+[0-9]+ ]]; then
                    # Keep other version directives as-is (likely already correct)
                    echo "$line" >> "$temp_file"
                else
                    echo "$line" >> "$temp_file"
                fi
            done < "$file"

            # Replace original file
            mv "$temp_file" "$file"
        else
            echo "    - No version directive, skipping"
        fi
    done
else
    echo "  ⚠️  OpenGL directory not found: $GL_DIR"
    echo "  Skipping shader version fixes..."
fi

echo "✅ Shader versions updated (or already compatible)!"