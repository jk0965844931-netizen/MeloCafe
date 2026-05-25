// iOS main entry point implementation

#include "iOSMain.h"
#include <iostream>

#if defined(TARGET_OS_IPHONE) && TARGET_OS_IPHONE

// Forward declarations
void iOSApplicationDidFinishLaunching();

// iOS main function
int iOSMain()
{
    std::cout << "[iOS] Starting MeloCafe..." << std::endl;
    
    // Initialize the app
    iOSApplicationDidFinishLaunching();
    
    // iOS handles the main loop, so we just return
    // The actual emulation will run in a separate thread
    return 0;
}

// This is a placeholder - real iOS apps would use UIApplicationMain
// but for this C++ emulator, we'll use a simpler approach
int iOSApplicationMain(int argc, char* argv[])
{
    std::cout << "[iOS] Application main" << std::endl;
    return iOSMain();
}

#endif // TARGET_OS_IPHONE