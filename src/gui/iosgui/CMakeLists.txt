# Minimal iOS GUI Stub for MeloCafe

add_library(CemuIOSGui STATIC
    IOSGui.cpp
)

target_include_directories(CemuIOSGui PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

target_link_libraries(CemuIOSGui PUBLIC
    CemuCore
)

if(IS_IOS)
    target_link_libraries(CemuIOSGui PUBLIC
        "-framework UIKit"
        "-framework QuartzCore"
        "-framework CoreGraphics"
        "-framework OpenGLES"
    )
endif()