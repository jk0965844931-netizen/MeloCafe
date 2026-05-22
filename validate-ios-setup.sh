#!/bin/bash

# Quick validation script for iOS build setup
# Run this locally to check for common issues before pushing to GitHub Actions

echo "🔍 MeloCafe iOS Build Validation"
echo "=================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

errors=0
warnings=0

# Check 1: Verify iOS toolchain exists
echo ""
echo "📋 Checking iOS toolchain..."
if [ -f "ios.toolchain.cmake" ]; then
    echo -e "${GREEN}✓${NC} ios.toolchain.cmake exists"
else
    echo -e "${RED}✗${NC} ios.toolchain.cmake not found"
    ((errors++))
fi

# Check 2: Verify entitlements exist
echo ""
echo "📋 Checking entitlements..."
if [ -f "ios/entitlements.plist" ]; then
    echo -e "${GREEN}✓${NC} ios/entitlements.plist exists"
    if grep -q "com.apple.security.cs.allow-jit" ios/entitlements.plist; then
        echo -e "${GREEN}✓${NC} JIT entitlement present"
    else
        echo -e "${YELLOW}⚠${NC} JIT entitlement may be missing"
        ((warnings++))
    fi
else
    echo -e "${RED}✗${NC} ios/entitlements.plist not found"
    ((errors++))
fi

# Check 3: Verify Info.plist exists
echo ""
echo "📋 Checking Info.plist..."
if [ -f "ios/Info.plist" ]; then
    echo -e "${GREEN}✓${NC} ios/Info.plist exists"
else
    echo -e "${RED}✗${NC} ios/Info.plist not found"
    ((errors++))
fi

# Summary
echo ""
echo "=================================="
echo "Validation Summary:"
echo -e "  Errors: ${RED}$errors${NC}"
echo -e "  Warnings: ${YELLOW}$warnings${NC}"

if [ $errors -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ All critical checks passed!${NC}"
    echo "Ready to push to GitHub Actions."
    exit 0
else
    echo ""
    echo -e "${RED}✗ $errors critical error(s) found. Fix before pushing.${NC}"
    exit 1
fi