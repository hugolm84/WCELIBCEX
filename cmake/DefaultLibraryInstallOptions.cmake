# Create ALIAS for this library, use Libname::Libname when linking
add_library(${exportname}::${exportname} ALIAS ${PROJECT_NAME})

#This is required so that the exported target has the name XnpFramework and not xnpframework
set_target_properties(${PROJECT_NAME} PROPERTIES EXPORT_NAME ${exportname})

# Install
set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/${exportname})

install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}-targets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}  # This is for Windows
)

if(NOT INSTALL_HEADERS)
    message(FATAL_ERROR "Your library does not seem to export and install any headers!")
endif()

# set INSTALL_HEADERS to source dir of headers to be installed. Usually public headers
foreach(INSTALL_DIR ${INSTALL_HEADERS})
    install(
        DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/${INSTALL_DIR}
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        FILES_MATCHING # install only matched files
        PATTERN "*.h" # select header files
    )
endforeach()

install(EXPORT ${PROJECT_NAME}-targets
    FILE
        ${exportname}Targets.cmake
    NAMESPACE
        ${exportname}::
    DESTINATION
        ${INSTALL_CONFIGDIR}
)

#Create a ConfigVersion.cmake file
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    ${PROJECT_BINARY_DIR}/${exportname}ConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

configure_package_config_file(
    ${PROJECT_SOURCE_DIR}/cmake/${exportname}Config.cmake.in
    ${PROJECT_BINARY_DIR}/${exportname}Config.cmake
    INSTALL_DESTINATION ${INSTALL_CONFIGDIR}
)

#Install the config, configversion and custom find modules
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${exportname}Config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${exportname}ConfigVersion.cmake
    DESTINATION ${INSTALL_CONFIGDIR}
)

export(EXPORT ${PROJECT_NAME}-targets
    FILE ${CMAKE_CURRENT_BINARY_DIR}/${exportname}Targets.cmake
    NAMESPACE ${exportname}::
)

#Register package in user's package registry
export(PACKAGE ${exportname})