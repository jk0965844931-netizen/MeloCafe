// Minimal iOS Application Delegate
// This handles iOS app lifecycle events

#pragma once

#ifdef __APPLE__
#include <TargetConditionals.h>
#endif

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE

#ifdef __cplusplus
extern "C" {
#endif

// iOS app lifecycle callbacks
void iOSApplicationDidFinishLaunching();
void iOSApplicationDidEnterBackground();
void iOSApplicationWillEnterForeground();
void iOSApplicationWillTerminate();

#ifdef __cplusplus
}
#endif

#endif // TARGET_OS_IPHONE