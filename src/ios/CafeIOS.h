// iOS-specific implementations for CemuCore dependencies
// This provides stub implementations for functions that don't exist on iOS

#pragma once

#ifdef __APPLE__
#include <TargetConditionals.h>
#endif

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE

#include <string>
#include <vector>
#include <cstdint>

namespace CafeIOS
{
    // iOS file system access (sandbox-aware)
    class iOSFileSystem
    {
    public:
        static std::string GetDocumentsDirectory();
        static std::string GetCacheDirectory();
        static std::string GetTemporaryDirectory();
        static bool FileExists(const std::string& path);
        static bool CreateDirectory(const std::string& path);
        static std::vector<uint8_t> ReadFile(const std::string& path);
        static bool WriteFile(const std::string& path, const std::vector<uint8_t>& data);
    };

    // iOS memory management
    class iOSMemory
    {
    public:
        static size_t GetAvailableMemory();
        static size_t GetTotalMemory();
        static void LowMemoryWarning();
    };

    // iOS display info
    class iOSDisplay
    {
    public:
        static float GetScreenScale();
        static int GetScreenWidth();
        static int GetScreenHeight();
        static bool IsPortrait();
        static bool IsLandscape();
    };

    // iOS audio output
    class iOSAudio
    {
    public:
        static bool Initialize();
        static void Shutdown();
        static void SetVolume(float volume);
        static float GetVolume();
    };

} // namespace CafeIOS

#endif // TARGET_OS_IPHONE