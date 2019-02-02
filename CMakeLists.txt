cmake_minimum_required(VERSION 3.12)

#Make sure that custom modules are found
list(INSERT CMAKE_MODULE_PATH 0 "${CMAKE_SOURCE_DIR}/cmake")

# Override, needs to called before PROJECT()
set(CMAKE_USER_MAKE_RULES_OVERRIDE ${CMAKE_MODULE_PATH}/CMake_Flag_Overrides.cmake)

project(
    wcelibcex
    VERSION 1.0.0
    DESCRIPTION "Package of C library extensions for Windows CE operating system."
    LANGUAGES C
)

set(exportname WinCeEx)

# Always use '-fPIC'/'-fPIE' option.
#If any target is shared, non pic/pie could result in instruction errors
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Default build type if -DCMAKE_BUILD_TYPE is not set
include(DefaultBuildType)

# Must use GNUInstallDirs to install libraries into correct
# locations on all platforms.
include(GNUInstallDirs)

# Remote default warning level
include(NoDefaultWarningLevel)

add_library(${PROJECT_NAME})

# Source files that the library depends on
target_sources(${PROJECT_NAME}
    PRIVATE
    src/wce_abort.c
    src/wce_getopt.c
    src/wce_setenvironmentvariable.c
    src/wce_gettimeofday.c
    src/wce_setlocale.c
    src/wce_asctime.c
    src/wce_lfind.c
    src/wce_stat.c
    src/wce_bsearch.c
    src/wce_localtime.c
    src/wce_strerror.c
    src/wce_clock.c
    src/wce_mbstowcs.c
    src/wce_time.c
    src/wce_ctime.c
    src/wce_mkdir.c
    src/wce_timesys.c
    src/wce_mktime.c
    src/wce_unlink.c
    src/wce_errno.c
    src/wce_path.c
    src/wce_wcstombs.c
    src/wce_findfile.c
    src/wce_rename.c
    src/wce_winbase.c
    src/wce_getenv.c
    src/wce_rewind.c
    src/wce_getenvironmentvariable.c
    src/wce_rmdir.c
    $<$<BOOL:${WITH_SHELL}>:src/wce_access.c>
    $<$<BOOL:${WITH_SHELL}>:src/wce_directorymanagement.c>
)

target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc>
        $<INSTALL_INTERFACE:include>
)

# Set default target options
include(DefaultTargetCompileOptions)

# Install all headers needed by the framework. Ideally, a list of PUBLIC headers
list(APPEND INSTALL_HEADERS "inc")
include(DefaultLibraryInstallOptions)
