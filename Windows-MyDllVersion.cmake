include (CMakeParseArguments)

set (GenerateProductVersionCurrentDir ${CMAKE_CURRENT_LIST_DIR})

# generate_product_dll_version () function
#
# This function uses Windows-MyDllVersionInfo.in template file and Windows-MyDllVersionResource.rc file
# to generate WIN32 resource with version information and general resource strings.
#
# Usage:
#   generate_product_dll_version (
#     SomeOutputResourceVariable
#     NAME MyGreatProject
#     VERSION_MAJOR 2
#     VERSION_MINOR 3
#     VERSION_PATH ${BUILD_COUNTER}
#     VERSION_REVISION ${BUILD_REVISION}
#   )
# where BUILD_COUNTER and BUILD_REVISION could be values from your CI server.
#
# You can use generated resource for your executable targets:
#   add_executable (target-name ${target-files} ${SomeOutputResourceVariable})
#
# You can specify resource strings in arguments:
#   NAME               - name of executable (no defaults, ex: Microsoft Word)
#   BUNDLE             - bundle (${NAME} is default, ex: Microsoft Office)
#   VERSION_MAJOR      - 0 is default
#   VERSION_MINOR      - 0 is default
#   VERSION_PATCH      - 0 is default
#   VERSION_REVISION   - 0 is default
#   COMPANY_NAME       - your company name (no defaults)
#   COMPANY_COPYRIGHT  - ${COMPANY_NAME} (C) Copyright ${CURRENT_YEAR} is default
#   COMMENTS           - ${NAME} v${VERSION_MAJOR}.${VERSION_MINOR} is default
#   ORIGINAL_FILENAME  - ${NAME} is default
#   INTERNAL_NAME      - ${NAME} is default
#   FILE_DESCRIPTION   - ${NAME} is default
function (generate_product_dll_version outfiles)
    set (options)
    set (oneValueArgs
        NAME
        BUNDLE
        VERSION_MAJOR
        VERSION_MINOR
        VERSION_PATCH
        VERSION_REVISION
        COMPANY_NAME
        COMPANY_COPYRIGHT
        COMMENTS
        ORIGINAL_FILENAME
        INTERNAL_NAME
        FILE_DESCRIPTION)
    set (multiValueArgs)
    cmake_parse_arguments (PRODUCT "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if (NOT PRODUCT_BUNDLE OR "${PRODUCT_BUNDLE}" STREQUAL "")
        set (PRODUCT_BUNDLE "${PRODUCT_NAME}")
    endif()

    if (NOT PRODUCT_VERSION_MAJOR OR "${PRODUCT_VERSION_MAJOR}" STREQUAL "")
        set (PRODUCT_VERSION_MAJOR 0)
    endif()
    if (NOT PRODUCT_VERSION_MINOR OR "${PRODUCT_VERSION_MINOR}" STREQUAL "")
        set (PRODUCT_VERSION_MINOR 0)
    endif()
    if (NOT PRODUCT_VERSION_PATCH OR "${PRODUCT_VERSION_PATCH}" STREQUAL "")
        set (PRODUCT_VERSION_PATCH 0)
    endif()
    if (NOT PRODUCT_VERSION_REVISION OR "${PRODUCT_VERSION_REVISION}" STREQUAL "")
        set (PRODUCT_VERSION_REVISION 0)
    endif()

    if (NOT PRODUCT_COMPANY_COPYRIGHT OR "${PRODUCT_COMPANY_COPYRIGHT}" STREQUAL "")
        string (TIMESTAMP PRODUCT_CURRENT_YEAR "%Y")
        set (PRODUCT_COMPANY_COPYRIGHT "${PRODUCT_COMPANY_NAME} (C) Copyright ${PRODUCT_CURRENT_YEAR}")
    endif()
    if (NOT PRODUCT_COMMENTS OR "${PRODUCT_COMMENTS}" STREQUAL "")
        set (PRODUCT_COMMENTS "${PRODUCT_NAME} v${PRODUCT_VERSION_MAJOR}.${PRODUCT_VERSION_MINOR}")
    endif()
    if (NOT PRODUCT_ORIGINAL_FILENAME OR "${PRODUCT_ORIGINAL_FILENAME}" STREQUAL "")
        set (PRODUCT_ORIGINAL_FILENAME "${PRODUCT_NAME}")
    endif()
    if (NOT PRODUCT_INTERNAL_NAME OR "${PRODUCT_INTERNAL_NAME}" STREQUAL "")
        set (PRODUCT_INTERNAL_NAME "${PRODUCT_NAME}")
    endif()
    if (NOT PRODUCT_FILE_DESCRIPTION OR "${PRODUCT_FILE_DESCRIPTION}" STREQUAL "")
        set (PRODUCT_FILE_DESCRIPTION "${PRODUCT_NAME}")
    endif()

    set (PRODUCT_VERSION "${PRODUCT_VERSION_MAJOR}.${PRODUCT_VERSION_MINOR}.${PRODUCT_VERSION_PATCH}.${PRODUCT_VERSION_REVISION}")
    string (MD5 _VersionDigest "${PRODUCT_BUNDLE}_${PRODUCT_NAME}_${PRODUCT_VERSION}")
    set (_VersionInfoFile ${CMAKE_CURRENT_BINARY_DIR}/rc.${_VersionDigest}/Windows-MyDllVersionInfo.h)
    set (_VersionResourceFile ${CMAKE_CURRENT_BINARY_DIR}/rc.${_VersionDigest}/Windows-MyDllVersionResource.rc)
    configure_file (
        ${GenerateProductVersionCurrentDir}/Windows-MyDllVersionInfo.in
        ${_VersionInfoFile}
        @ONLY)
    configure_file (
        ${GenerateProductVersionCurrentDir}/Windows-MyDllVersionResource.rc
        ${_VersionResourceFile}
        COPYONLY)
    list (APPEND ${outfiles} ${_VersionInfoFile} ${_VersionResourceFile})
    set (${outfiles} ${${outfiles}} PARENT_SCOPE)
endfunction()
