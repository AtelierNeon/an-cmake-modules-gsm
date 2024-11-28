# This module is used to detect if there is a compiler cache tool on host machine.
#
# Currently Ccache (https://ccache.dev/) is supported.
message (STATUS "Detecting compiler cache")
find_program (CCACHE_SHIM_EXECUTABLE_PATH
    NAMES ccache)
if (NOT CCACHE_SHIM_EXECUTABLE_PATH)
  message (STATUS "Detecting compiler cache - not found")
else ()
  ## Example ${ccache_version_output}:
  #
  # C:\>ccache --version
  # ccache version 4.10.2
  # Features: avx2 file-storage http-storage redis+unix-storage redis-storage
  execute_process (COMMAND ${CCACHE_SHIM_EXECUTABLE_PATH} --version
      OUTPUT_VARIABLE ccache_version_output
      RESULT_VARIABLE ccache_version_exit_code
      ERROR_QUIET
      OUTPUT_STRIP_TRAILING_WHITESPACE)
  if ("${ccache_version_exit_code}" STREQUAL "0")
    string (REGEX MATCH "ccache\ version\ ([0-9])+.([0-9])+.([0-9])+\n" ccache_version_output "${ccache_version_output}")
    string (REGEX REPLACE "\n$" "" ccache_version_output "${ccache_version_output}")
    string (REPLACE "ccache\ version\ " "" ccache_version_output ${ccache_version_output})
    set (CCACHE_EXECUTABLE_VERSION ${ccache_version_output})
  else ()
    set (CCACHE_EXECUTABLE_VERSION "UNKNOWN_VERSION")
  endif ()

  if (WIN32)
    ## Example ${ccache_path_output}:
    #
    # C:\>ccache --shimgen-noop
    # [shim]: Set up Shim to run with the following parameters:
    # path to executable: C:\ProgramData\chocolatey\lib\ccache\tools\ccache-4.10.2-windows-x86_64\ccache.exe
    # working directory: C:\
    # is gui? False
    # wait for exit? True
    # command (optional):
    execute_process (COMMAND ${CCACHE_SHIM_EXECUTABLE_PATH} --shimgen-noop
        OUTPUT_VARIABLE ccache_path_output
        RESULT_VARIABLE ccache_path_exit_code
        ERROR_QUIET)
    if ("${ccache_path_exit_code}" STREQUAL "-1")
      string (REGEX MATCH "path\ to\ executable:.*exe\n" ccache_path_output "${ccache_path_output}")
      string (REGEX REPLACE "\n$" "" ccache_path_output "${ccache_path_output}")
      string (REPLACE "path\ to\ executable:\ " "" ccache_path_output ${ccache_path_output})
      set (CCACHE_EXECUTABLE_PATH ${ccache_path_output})
    else ()
      set (CCACHE_EXECUTABLE_PATH ${CCACHE_SHIM_EXECUTABLE_PATH})
    endif ()
  else ()
    set (CCACHE_EXECUTABLE_PATH ${CCACHE_SHIM_EXECUTABLE_PATH})
  endif ()

  message (STATUS "Detecting compiler cache - Ccache ${CCACHE_EXECUTABLE_VERSION} in ${CCACHE_EXECUTABLE_PATH}")

  if (MSVC)
    file (COPY_FILE ${CCACHE_EXECUTABLE_PATH} ${CMAKE_BINARY_DIR}/cl.exe
        ONLY_IF_DIFFERENT)
    set (CMAKE_VS_GLOBALS
        "CLToolExe=cl.exe"
        "CLToolPath=${CMAKE_BINARY_DIR}"
        "TrackFileAccess=false"
        "UseMultiToolTask=true"
        "DebugInformationFormat=OldStyle")
    message (STATUS "Using Ccache ${CCACHE_EXECUTABLE_VERSION} as MSVC compiler cache")
  else ()
    set (CMAKE_C_COMPILER_LAUNCHER ${CCACHE_EXECUTABLE_PATH})
    set (CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_EXECUTABLE_PATH})
    message (STATUS "Using Ccache ${CCACHE_EXECUTABLE_VERSION} as compiler cache")
  endif ()
endif ()
