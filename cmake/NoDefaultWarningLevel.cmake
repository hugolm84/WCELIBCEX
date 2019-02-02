if(MSVC)
    # Remove default Warning level W3 and let the target set it
    option(NO_DEFAULT_MSVC_WARNING_LEVEL "Removes the default warning level for MSVC (W3)" ON)
    if (NO_DEFAULT_MSVC_WARNING_LEVEL AND NOT DEFAULT_LEVEL_REMOVED)
        if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
            string(REGEX REPLACE "/W[0-4]" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
            set(DEFAULT_LEVEL_REMOVED TRUE)
        endif()
    endif()

    if (MSVC AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 19.14)
        option(ENABLE_MSVC_WALL "Enables -Wall for MSVC." OFF)
        if(ENABLE_MSVC_WALL)
            target_compile_options(${PROJECT_NAME}
                PRIVATE
                    /experimental:external
                    /external:anglebrackets
                    /external:env:WindowsSdkDir
                    /external:W0
                    /wd4514 #unreferenced inline function has been removed
                    /external:I "${CMAKE_CURRENT_SOURCE_DIR}/../../common/xnpinterfaces"
                    /Wall
            )
            message(STATUS "Adding /Wall to target ${PROJECT_NAME}")
        endif()
    endif()
endif()
