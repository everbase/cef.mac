# Copyright (c) 2014 The Chromium Embedded Framework Authors. All rights
# reserved. Use of this source code is governed by a BSD-style license that
# can be found in the LICENSE file.

#
# Source files.
#

# cefevb sources.
set( CEFEVB_SRCS
    EVBAppDelegate.h
    EVBAppDelegate.mm
    EVBWebWindow.h
    EVBWebWindow.mm
    evb_app.h
    evb_app.cc
    evb_app_mac.mm
    evb_handler.h
    evb_handler.cc
    evb_handler_mac.mm
    cefevb_mac.mm
)

# cefevb helper sources.
set( CEFEVB_HELPER_SRCS
    process_helper_mac.cc
)

# cefevb resources.
set( CEFEVB_RESOURCES_SRCS
    mac/Info.plist
    mac/cefevb.icns
    mac/MainMenu.xib
)


#
# Shared configuration.
#

# Target executable names.
set( CEF_TARGET "cefevb" )

set( CEF_HELPER_TARGET "cefevb_Helper" )
set( CEF_HELPER_OUTPUT_NAME "cefevb Helper" )

# Logical target used to link the libcef library.
ADD_LOGICAL_TARGET( "libcef_lib" "${CEF_LIB_DEBUG}" "${CEF_LIB_RELEASE}" )

# Determine the target output directory.
SET_CEF_TARGET_OUT_DIR()


#
# Mac OS X configuration.
#

list( APPEND CEF_COMPILER_FLAGS
    -Wno-objc-missing-property-synthesis   # Don't warn about auto-synthesized properties
)

# Output paths for the app bundles.
set( CEF_APP "${CEF_TARGET_OUT_DIR}/${CEF_TARGET}.app" )
set( CEF_HELPER_APP "${CEF_TARGET_OUT_DIR}/${CEF_HELPER_OUTPUT_NAME}.app" )

# Variable referenced from Info.plist files.
set( PRODUCT_NAME "${CEF_TARGET}" )

# Helper executable target.
add_executable( ${CEF_HELPER_TARGET} MACOSX_BUNDLE ${CEFEVB_HELPER_SRCS} )
SET_EXECUTABLE_TARGET_PROPERTIES( ${CEF_HELPER_TARGET} )
add_dependencies( ${CEF_HELPER_TARGET} libcef_dll_wrapper )
target_link_libraries( ${CEF_HELPER_TARGET} libcef_lib libcef_dll_wrapper ${CEF_STANDARD_LIBS} )
set_target_properties( ${CEF_HELPER_TARGET} PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/mac/helper-Info.plist
    OUTPUT_NAME ${CEF_HELPER_OUTPUT_NAME}
)

# Fix the framework rpath in the helper executable.
FIX_MACOSX_HELPER_FRAMEWORK_RPATH( ${CEF_HELPER_TARGET} )

# Main executable target.
add_executable( ${CEF_TARGET} MACOSX_BUNDLE ${CEFEVB_RESOURCES_SRCS} ${CEFEVB_SRCS} )
SET_EXECUTABLE_TARGET_PROPERTIES( ${CEF_TARGET} )
add_dependencies( ${CEF_TARGET} libcef_dll_wrapper "${CEF_HELPER_TARGET}" )
target_link_libraries( ${CEF_TARGET} libcef_lib libcef_dll_wrapper ${CEF_STANDARD_LIBS} )
set_target_properties( ${CEF_TARGET} PROPERTIES
    MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/mac/Info.plist
)

# Copy files into the main app bundle.
add_custom_command(
    TARGET ${CEF_TARGET}
    POST_BUILD
    # Copy the helper app bundle into the Frameworks directory.
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${CEF_HELPER_APP}"
            "${CEF_APP}/Contents/Frameworks/${CEF_HELPER_OUTPUT_NAME}.app"
    # Copy the CEF framework into the Frameworks directory.
    COMMAND ${CMAKE_COMMAND} -E copy_directory
            "${CEF_BINARY_DIR}/Chromium Embedded Framework.framework"
            "${CEF_APP}/Contents/Frameworks/Chromium Embedded Framework.framework"
    VERBATIM
)

# Fix the framework rpath in the main executable.
FIX_MACOSX_MAIN_FRAMEWORK_RPATH( ${CEF_TARGET} )

# Manually process and copy over resource files.
# The Xcode generator can support this via the set_target_properties RESOURCE
# directive but that doesn't properly handle nested resource directories.
# Remove these prefixes from input file paths.
set( PREFIXES "mac/" )
COPY_MACOSX_RESOURCES( "${CEFEVB_RESOURCES_SRCS}" "${PREFIXES}" "${CEF_TARGET}" "${CMAKE_CURRENT_SOURCE_DIR}" "${CEF_APP}" )
