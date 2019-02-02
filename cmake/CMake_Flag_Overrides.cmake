if(WINCE)
    # CMake default values are wrong!
    # https://gitlab.kitware.com/cmake/cmake/blob/master/Modules/Platform/Windows-MSVC.cmake
    # CommCtrl.lib does not exist in headless WINCE
    # Adding this will make CMake Try_Compile succeed and therefore also
    # C/C++ ABI Detetection work
    set(CMAKE_C_STANDARD_LIBRARIES_INIT "coredll.lib ole32.lib oleaut32.lib uuid.lib")
    set(CMAKE_CXX_STANDARD_LIBRARIES_INIT ${CMAKE_C_STANDARD_LIBRARIES_INIT})
    foreach(t EXE SHARED MODULE)
        string(APPEND CMAKE_${t}_LINKER_FLAGS_INIT " /NODEFAULTLIB:libc.lib /NODEFAULTLIB:oldnames.lib")
    endforeach()
endif()
