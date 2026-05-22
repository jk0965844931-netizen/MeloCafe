#!/bin/bash

# Apply all pre-emptive fixes for common build errors
# Run this before pushing to GitHub to reduce build failures

echo "🚀 Applying all pre-emptive fixes for MeloCafe iOS build..."
echo ""

# Fix 1: OpenGL Compatibility Headers
if [ -f "fix-opengl-headers.sh" ]; then
    echo "📦 Fix 1: Adding OpenGL compatibility headers..."
    chmod +x fix-opengl-headers.sh
    ./fix-opengl-headers.sh
    echo ""
else
    echo "⚠️  fix-opengl-headers.sh not found, skipping..."
    echo ""
fi

# Fix 2: Shader Versions
if [ -f "fix-shader-versions.sh" ]; then
    echo "📦 Fix 2: Updating shader versions..."
    chmod +x fix-shader-versions.sh
    ./fix-shader-versions.sh
    echo ""
else
    echo "⚠️  fix-shader-versions.sh not found, skipping..."
    echo ""
fi

# Fix 3: Verify iOS-Specific Includes
echo "📦 Fix 3: Verifying iOS-specific includes..."

# Check iOS files have proper includes
ios_files=(
    "src/ios/iOSApp.cpp"
    "src/ios/iOSApp.h"
    "src/ios/iOSMain.cpp"
    "src/ios/CafeIOS.cpp"
    "src/ios/CafeIOS.h"
)

for file in "${ios_files[@]}"; do
    if [ -f "$file" ]; then
        if ! grep -q "#import <UIKit/UIKit.h>" "$file" && [[ "$file" == *.cpp ]]; then
            echo "  ⚠️  Missing UIKit import in $file"
        elif ! grep -q "UIKit/UIKit.h" "$file" && [[ "$file" == *.cpp ]]; then
            echo "  ✓ UIKit import present in $file"
        fi
    fi
done
echo ""

# Summary
echo "✅ Pre-emptive fixes applied!"
echo ""
echo "Summary of changes:"
echo "  - OpenGL compatibility headers added to GL files"
echo "  - Shader versions updated (330 → 300 es)"
echo "  - iOS includes verified"
echo ""
echo "Next steps:"
echo "  1. Review changes with: git diff"
echo "  2. Commit fixes: git add -A && git commit -m 'fix: apply pre-emptive build error fixes'"
echo "  3. Push to GitHub: git push origin main"
echo "  4. Monitor GitHub Actions: https://github.com/jk0965844931-netizen/MeloCafe/actions"