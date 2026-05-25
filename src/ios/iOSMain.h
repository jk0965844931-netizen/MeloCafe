// iOS main entry point
// iOS doesn't use traditional main() - it uses UIApplicationMain

#pragma once

#ifdef __APPLE__
#include <TargetConditionals.h>
#endif

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE

#ifdef __cplusplus
extern "C" {
#endif

// This is called by iOS when the app launches
int iOSMain();

// Start the iOS application
int iOSApplicationMain(int argc, char* argv[]);

#ifdef __cplusplus
}
#endif

#endif // TARGET_OS_IPHONE