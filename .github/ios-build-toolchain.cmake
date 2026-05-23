# iOS CMake Toolchain File
set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_SYSTEM_VERSION 14.0)
set(CMAKE_OSX_ARCHITECTURES arm64)
set(CMAKE_OSX_DEPLOYMENT_TARGET 14.0)
set(CMAKE_OSX_SYSROOT iphoneos)

# Enable iOS-specific behavior
set(CMAKE_XCODE_EFFECTIVE_PLATFORMS "-iphoneos")
set(CMAKE_OSX_DEPLOYMENT_TARGET 14.0)

# Ensure we're building for iOS
set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(CMAKE_C_COMPILER_TARGET aarch64-apple-ios)
set(CMAKE_CXX_COMPILER_TARGET aarch64-apple-ios)

# Build type
set(CMAKE_BUILD_TYPE Release)

# Set iOS platform flags
set(CMAKE_MACOSX_BUNDLE ON)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fvisibility=hidden -fno-common")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden -fno-common")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-dead_strip")
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,-dead_strip")

# iOS-specific compile definitions
add_definitions(-DTARGET_OS_IPHONE=1)
add_definitions(-D__APPLE__=1)

# Disable problematic features on iOS
set(ENABLE_OPENGL OFF CACHE BOOL "" FORCE)
set(ENABLE_VULKAN OFF CACHE BOOL "" FORCE)
set(ENABLE_WXWIDGETS OFF CACHE BOOL "" FORCE)
set(ENABLE_SDL ON CACHE BOOL "" FORCE)
set(ENABLE_BLUEZ OFF CACHE BOOL "" FORCE)
set(ENABLE_DISCORD_RPC OFF CACHE BOOL "" FORCE)
set(ENABLE_HIDAPI OFF CACHE BOOL "" FORCE)
set(ENABLE_CUBEB OFF CACHE BOOL "" FORCE)