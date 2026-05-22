add_library(CemuGui INTERFACE)
target_include_directories(CemuGui INTERFACE "interface")

if(ENABLE_WXWIDGETS)
    add_subdirectory(wxgui)
    target_link_libraries(CemuGui INTERFACE CemuWxGui)
elseif(IS_IOS)
    # iOS uses a minimal UI stub
    message(STATUS "Building with iOS stub GUI")
    add_subdirectory(iosgui)
    target_link_libraries(CemuGui INTERFACE CemuIOSGui)
endif()
