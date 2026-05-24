// iOS-specific source files

set(IOS_SOURCES
    ios/iOSApp.cpp
    ios/iOSMain.cpp
    ios/CafeIOS.cpp
)

set(IOS_HEADERS
    ios/iOSApp.h
    ios/iOSMain.h
    ios/CafeIOS.h
)

if(IS_IOS)
    # Add iOS sources to CemuBin target (main entry point)
    target_sources(CemuBin PRIVATE ${IOS_SOURCES})
    target_include_directories(CemuBin PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
    
    # Add iOS compile definitions to CemuBin
    target_compile_definitions(CemuBin PRIVATE
        TARGET_OS_IPHONE=1
        USE_GLES=1
    )
    
    # Create iOS library for other parts
    add_library(CemuIOS STATIC ios/CafeIOS.cpp)
    
    target_include_directories(CemuIOS PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
    )
    
    # Link with iOS frameworks
    target_link_libraries(CemuIOS PUBLIC
        "-framework UIKit"
        "-framework Foundation"
        "-framework QuartzCore"
        "-framework CoreGraphics"
        "-framework OpenGLES"
        "-framework AVFoundation"
        "-framework AudioToolbox"
    )
    
    # Add iOS compile definitions
    target_compile_definitions(CemuIOS PUBLIC
        TARGET_OS_IPHONE=1
        USE_GLES=1
    )
endif()