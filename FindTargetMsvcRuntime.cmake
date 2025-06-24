# This module is used to detect if there is a target MSVC runtime library on host machine.
#
# Currently MSVC v142 / v143 is supported.
message (STATUS "Target MSVC runtime for ${CMAKE_GENERATOR_PLATFORM}")

if ("${CMAKE_GENERATOR_PLATFORM}" STREQUAL "x64")
  set (_MSVC_PLATFORM "x64")
elseif ("${CMAKE_GENERATOR_PLATFORM}" STREQUAL "Win32")
  set (_MSVC_PLATFORM "x86")
else ()
  set (_MSVC_PLATFORM "x86")
endif ()

if (MSVC)
  # CMAKE_C_COMPILER example:
  # C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x86/cl.exe
  #
  # _MSVC_COMPILER_PARENT_DIR example:
  # C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC
  get_filename_component(_MSVC_COMPILER_PARENT_DIR ${CMAKE_C_COMPILER} DIRECTORY)
  get_filename_component(_MSVC_COMPILER_PARENT_DIR ${_MSVC_COMPILER_PARENT_DIR} DIRECTORY)
  get_filename_component(_MSVC_COMPILER_PARENT_DIR ${_MSVC_COMPILER_PARENT_DIR} DIRECTORY)
  get_filename_component(_MSVC_COMPILER_PARENT_DIR ${_MSVC_COMPILER_PARENT_DIR} DIRECTORY)

  # _MSVC_TOOL_LONG_VERSION example:
  # 14.44.35207
  get_filename_component(_MSVC_TOOL_LONG_VERSION ${_MSVC_COMPILER_PARENT_DIR} NAME)

  if ("${_MSVC_TOOL_LONG_VERSION}" MATCHES "^([0-9]+)\\.([0-9]+)")
    # _MSVC_TOOL_VERSION example:
    # 14.44
    set (_MSVC_TOOL_VERSION "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}")

    # _MSVC_COMPILER_PARENT_DIR example:
    # C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC
    get_filename_component(_MSVC_COMPILER_PARENT_DIR ${_MSVC_COMPILER_PARENT_DIR} DIRECTORY)
    get_filename_component(_MSVC_COMPILER_PARENT_DIR ${_MSVC_COMPILER_PARENT_DIR} DIRECTORY)
    get_filename_component(_MSVC_COMPILER_PARENT_DIR ${_MSVC_COMPILER_PARENT_DIR} DIRECTORY)

  message (STATUS "_MSVC_COMPILER_PARENT_DIR: ${_MSVC_COMPILER_PARENT_DIR}")

    # _MSVC_REDIST_PATH example:
    # C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Redist/MSVC/14.29.30133/debug_nonredist/x86
    file (GLOB _MSVC_REDIST_ROOTS
      LIST_DIRECTORIES TRUE
      "${_MSVC_COMPILER_PARENT_DIR}/Redist/MSVC/${_MSVC_TOOL_VERSION}.*"
    )
    foreach (_MSVC_REDIST_ROOT ${_MSVC_REDIST_ROOTS})
      if (IS_DIRECTORY ${_MSVC_REDIST_ROOT})
        set (_MSVC_REDIST_PATH ${_MSVC_REDIST_ROOT}/${_MSVC_PLATFORM})
        if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
          set (_MSVC_REDIST_PATH "${_MSVC_REDIST_ROOT}/debug_nonredist/${_MSVC_PLATFORM}")
        endif ()
      endif ()
    endforeach ()

    # _MSVC_REDIST_FILE example:
    # C:/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Redist/MSVC/14.29.30133/debug_nonredist/x86/Microsoft.VC142.DebugCRT/concrt140d.dll
    file (GLOB_RECURSE _MSVC_REDIST_FILES
      "${_MSVC_REDIST_PATH}/*"
    )
    foreach (_MSVC_REDIST_FILE ${_MSVC_REDIST_FILES})
      if (NOT IS_DIRECTORY ${_MSVC_REDIST_FILE})
        # CRT
        if (${_MSVC_REDIST_FILE} MATCHES "concrt140.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "concrt140d.dll$")
          set (MSVCRUNTIME_CONCRT140_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "msvcp140.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "msvcp140d.dll$")
          set (MSVCRUNTIME_MSVCP140_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "msvcp140_1.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "msvcp140_1d.dll$")
          set (MSVCRUNTIME_MSVCP140_1_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "msvcp140_2.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "msvcp140_2d.dll$")
          set (MSVCRUNTIME_MSVCP140_2_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "msvcp140_atomic_wait.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "msvcp140d_atomic_wait.dll$")
          set (MSVCRUNTIME_MSVCP140_ATOMIC_WAIT_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "msvcp140_codecvt_ids.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "msvcp140d_codecvt_ids.dll$")
          set (MSVCRUNTIME_MSVCP140_CODECVT_IDS_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "vccorlib140.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "vccorlib140d.dll$")
          set (MSVCRUNTIME_VCCORLIB140_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "vcruntime140.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "vcruntime140d.dll$")
          set (MSVCRUNTIME_VCRUNTIME140_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "vcruntime140_1.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "vcruntime140_1d.dll$")
          set (MSVCRUNTIME_VCRUNTIME140_1_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "vcruntime140_threads.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "vcruntime140_threadsd.dll$")
          set (MSVCRUNTIME_VCRUNTIME140_THREADS_DLL ${_MSVC_REDIST_FILE})
        # CXXAMP
        elseif (${_MSVC_REDIST_FILE} MATCHES "vcamp140.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "vcamp140d.dll$")
          set (MSVCRUNTIME_VCAMP140_DLL ${_MSVC_REDIST_FILE})
        # MFC
        elseif (${_MSVC_REDIST_FILE} MATCHES "mfc140.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "mfc140d.dll$")
          set (MSVCRUNTIME_MFC140_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "mfc140u.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "mfc140ud.dll$")
          set (MSVCRUNTIME_MFC140U_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "mfcm140.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "mfcm140d.dll$")
          set (MSVCRUNTIME_MFCM140_DLL ${_MSVC_REDIST_FILE})
        elseif (${_MSVC_REDIST_FILE} MATCHES "mfcm140u.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "mfcm140ud.dll$")
          set (MSVCRUNTIME_MFCM140U_DLL ${_MSVC_REDIST_FILE})
        # OpenMP
        elseif (${_MSVC_REDIST_FILE} MATCHES "vcomp140.dll$" OR ${_MSVC_REDIST_FILE} MATCHES "vcomp140d.dll$")
          set (MSVCRUNTIME_VCOMP140_DLL ${_MSVC_REDIST_FILE})
        # Others
        else ()
          # message(STATUS "_MSVC_REDIST_FILE: ${_MSVC_REDIST_FILE}")
        endif ()
      endif ()
    endforeach ()

    # CMAKE_SYSTEM_VERSION example:
    # 10.0.22621
    if ("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
      file (GLOB _UCRT_REDIST_DEBUG_ROOTS
        LIST_DIRECTORIES TRUE
        "C:/Program Files (x86)/Windows Kits/10/bin/${CMAKE_SYSTEM_VERSION}.*"
      )
      foreach (_UCRT_REDIST_DEBUG_ROOT ${_UCRT_REDIST_DEBUG_ROOTS})
        if (IS_DIRECTORY ${_UCRT_REDIST_DEBUG_ROOT})
          set (_UCRT_REDIST_PATH "${_UCRT_REDIST_DEBUG_ROOT}/${_MSVC_PLATFORM}/ucrt")
        endif ()
      endforeach ()
    else ()
      file (GLOB _UCRT_REDIST_RELEASE_ROOTS
        LIST_DIRECTORIES TRUE
        "C:/Program Files (x86)/Windows Kits/10/Redist/${CMAKE_SYSTEM_VERSION}.*"
      )
      foreach (_UCRT_REDIST_RELEASE_ROOT ${_UCRT_REDIST_RELEASE_ROOTS})
        if (IS_DIRECTORY ${_UCRT_REDIST_RELEASE_ROOT})
          set (_UCRT_REDIST_PATH "${_UCRT_REDIST_RELEASE_ROOT}/ucrt/DLLs/${_MSVC_PLATFORM}")
        endif ()
      endforeach ()
    endif ()

    # _UCRT_REDIST_FILE example:
    # C:/Program Files (x86)/Windows Kits/10/bin/10.0.22621.0/x86/ucrt/ucrtbased.dll
    file (GLOB_RECURSE _UCRT_REDIST_FILES
      "${_UCRT_REDIST_PATH}/*"
    )
    foreach (_UCRT_REDIST_FILE ${_UCRT_REDIST_FILES})
      if (NOT IS_DIRECTORY ${_UCRT_REDIST_FILE})
        if (${_UCRT_REDIST_FILE} MATCHES "ucrtbase.dll$" OR ${_UCRT_REDIST_FILE} MATCHES "ucrtbased.dll$")
          set (MSVCRUNTIME_UCRTBASE_DLL ${_UCRT_REDIST_FILE})
        endif ()
      endif ()
    endforeach ()

    set (MSVCRUNTIME_FOUND TRUE)
    message (STATUS "Target MSVC runtime for ${CMAKE_GENERATOR_PLATFORM} - FOUND")
  else ()
    message (STATUS "Target MSVC runtime for ${CMAKE_GENERATOR_PLATFORM} - NOT FOUND")
  endif ()
else ()
  message (STATUS "Target MSVC runtime for ${CMAKE_GENERATOR_PLATFORM} - NOT FOUND")
endif ()
