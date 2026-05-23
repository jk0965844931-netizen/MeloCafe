# iOS CMake Toolchain File
# This file configures CMake for cross-compiling to iOS

set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_SYSTEM_VERSION 14.0)
set(CMAKE_OSX_ARCHITECTURES arm64)
set(CMAKE_OSX_DEPLOYMENT_TARGET 14.0)

# Set the search paths for the iOS SDK
set(CMAKE_OSX_SYSROOT iphoneos)

# Disable building of tests and examples by default
set(CMAKE_FIND_FRAMEWORK LAST)

# Set the install name prefix
set(CMAKE_INSTALL_NAME_DIR @rpath)

# Don't treat headers as system headers (needed for some packages)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fno-common")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-common -fvisibility-inlines-hidden")

# Enable position independent code
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# iOS specific flags
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fembed-bitcode")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fembed-bitcode")

# Disable some features that don't work well on iOS
set(ENABLE_OPENGL OFF CACHE BOOL "Disable OpenGL on iOS" FORCE)
set(ENABLE_VULKAN OFF CACHE BOOL "Disable Vulkan on iOS" FORCE)
set(ENABLE_WXWIDGETS OFF CACHE BOOL "Disable wxWidgets on iOS" FORCE)
set(ENABLE_SDL ON CACHE BOOL "Enable SDL on iOS" FORCE)
set(ENABLE_BLUEZ OFF CACHE BOOL "Disable BlueZ on iOS" FORCE)
set(ENABLE_DISCORD_RPC OFF CACHE BOOL "Disable Discord RPC on iOS" FORCE)
set(ENABLE_HIDAPI OFF CACHE BOOL "Disable HIDAPI on iOS" FORCE)
set(ENABLE_VCPKG ON CACHE BOOL "Enable vcpkg for iOS" FORCE)
set(ENABLE_CUBEB OFF CACHE BOOL "Disable cubeb on iOS" FORCE)

# iOS-specific compile definitions
add_definitions(-DTARGET_OS_IPHONE=1)
add_definitions(-D__APPLE__=1)