# This is the default target properties any project should use
# include this file to set them

set_target_properties(${PROJECT_NAME}
  PROPERTIES
    VERSION ${PROJECT_VERSION} # Descriptive version for this lib used in symlinks
    SOVERSION ${PROJECT_VERSION_MAJOR} # SoVersion is indicator for ABI compatibillity.
    DEBUG_POSTFIX "-d"
)

set_target_properties(${PROJECT_NAME}
    PROPERTIES
        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED YES
        CXX_EXTENSIONS NO # Makes CMake add -std=c++11 instead of GNU++11 (on GCC)
)

if(exportname)
    set_target_properties(${PROJECT_NAME}
        PROPERTIES
            EXPORT_NAME ${exportname}
        )
endif()

# All targets are compiled with Wall or W4 by default
target_compile_options(${PROJECT_NAME}
    PRIVATE
        $<$<OR:$<CXX_COMPILER_ID:Clang>,$<CXX_COMPILER_ID:GNU>>:
            $<$<CONFIG:Debug>:-O0 -Wall -Wextra>
            $<$<CONFIG:Release>:-Wall -Wextra>
            $<$<BOOL:${WARNINGS_AS_ERROR}>:-Werror>>
        $<$<CXX_COMPILER_ID:MSVC>:
            $<$<CONFIG:Debug>:/Od /Zi /W4>
            $<$<CONFIG:Release>:/W4>
            $<$<BOOL:${WARNINGS_AS_ERROR}>:/WX>>
)

# Static Code analysis
if(USE_CLANG_TIDY)
    set_target_properties(${PROJECT_NAME}
        PROPERTIES
            CXX_CLANG_TIDY "${DO_CLANG_TIDY}"
    )
endif()

# iwyu (include what you use) : This parses C++ source files and determines the exact include
# files required to compile that file, no more no less.
# Todo: add --transitive_includes_only?
find_program(iwyu_path NAMES include-what-you-use iwyu)
if(iwyu_path)
    set_target_properties(${PROJECT_NAME}
        PROPERTIES
            C_INCLUDE_WHAT_YOU_USE ${iwyu_path}
            CXX_INCLUDE_WHAT_YOU_USE ${iwyu_path}
    )
endif()

# lwyu (link what you use): This is a built in CMake feature that uses options of ld and
# ldd to print out if executables link more libraries than they actually require.
if (NOT WIN32)
    set(CMAKE_LINK_WHAT_YOU_USE ON)
endif()