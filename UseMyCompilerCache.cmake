message (STATUS "Detecting compiler cache")
find_program (CCACHE_SHIM_EXECUTABLE_PATH
    NAMES ccache)
if (NOT CCACHE_SHIM_EXECUTABLE_PATH)
  message (STATUS "Detecting compiler cache - not found")
else ()
  ## Example ${ccache_version_output}:
  #
  # C:\>ccache --print-version
  # 4.10.2
  execute_process (COMMAND ${CCACHE_SHIM_EXECUTABLE_PATH} --print-version
      OUTPUT_VARIABLE ccache_version_output
      RESULT_VARIABLE ccache_version_exit_code
      ERROR_QUIET
      OUTPUT_STRIP_TRAILING_WHITESPACE)
  if ("${ccache_version_exit_code}" STREQUAL "0")
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
    # [shim]: Command line 'ccache  --shimgen-noop'
    # [shim]: Current process '"C:\ProgramData\chocolatey\bin\ccache.exe"'
    # [shim]: Command line after removing process 'ccache  --shimgen-noop'
    # [shim]: Shifting off the first argument since process didn't catch it
    # [shim]: Arguments after removing shimgen args - ''
    # [shim]: Arguments are ''
    execute_process (COMMAND ${CCACHE_SHIM_EXECUTABLE_PATH} --shimgen-noop
        OUTPUT_VARIABLE ccache_path_output
        RESULT_VARIABLE ccache_path_exit_code
        ERROR_QUIET)
    if ("${ccache_path_exit_code}" STREQUAL "-1")
      string (REGEX MATCH "path\ to\ executable:.*exe\n" ccache_path_output "${ccache_path_output}")
      string (REGEX REPLACE "\n$" "" ccache_path_output "${ccache_path_output}")
      string (REPLACE "path\ to\ executable: " "" ccache_path_output ${ccache_path_output})
      set (CCACHE_EXECUTABLE_PATH ${ccache_path_output})
    else ()
      set (CCACHE_EXECUTABLE_PATH ${CCACHE_SHIM_EXECUTABLE_PATH})
    endif ()
  else ()
    set (CCACHE_EXECUTABLE_PATH ${CCACHE_SHIM_EXECUTABLE_PATH})
  endif ()

  message (STATUS "Detecting compiler cache - CCache ${CCACHE_EXECUTABLE_VERSION} in ${CCACHE_EXECUTABLE_PATH}")

  if (MSVC)
    file (COPY_FILE ${CCACHE_EXECUTABLE_PATH} ${CMAKE_BINARY_DIR}/cl.exe
        ONLY_IF_DIFFERENT)
    set (CMAKE_VS_GLOBALS
        "CLToolExe=cl.exe"
        "CLToolPath=${CMAKE_BINARY_DIR}"
        "TrackFileAccess=false"
        "UseMultiToolTask=true"
        "DebugInformationFormat=OldStyle")
    message (STATUS "Using CCache ${CCACHE_EXECUTABLE_VERSION} as MSVC compiler cache")
  else ()
    set (CMAKE_C_COMPILER_LAUNCHER ${CCACHE_EXECUTABLE_PATH})
    set (CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE_EXECUTABLE_PATH})
    message (STATUS "Using CCache ${CCACHE_EXECUTABLE_VERSION} as compiler cache")
  endif ()
endif ()
