# Workflow Test

This file is used to trigger GitHub Actions workflow after fixing the workflow configuration.

**Changes made:**
- Removed incorrect Xcode-based workflow (build-unsigned-ipa.yml)
- Updated build-ios.yml for macos-15-arm64 runner with Xcode 16.4

**Expected result:**
- Workflow should now run successfully
- Unsigned IPA will be uploaded as artifact
- Check Actions tab for build result

---

Date: 2026-05-23
Status: 🧪 Testing workflow