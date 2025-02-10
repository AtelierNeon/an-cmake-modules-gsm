cmake_policy(PUSH)
cmake_policy(SET CMP0159 NEW) # file(STRINGS) with REGEX updates CMAKE_MATCH_<n>

function(protobuf_generate)
  set(_options APPEND_PATH DESCRIPTORS)
  set(_singleargs LANGUAGE OUT_VAR EXPORT_MACRO PROTOC_OUT_DIR PLUGIN PLUGIN_OPTIONS DEPENDENCIES)
  if(COMMAND target_sources)
    list(APPEND _singleargs TARGET)
  endif()
  set(_multiargs PROTOS IMPORT_DIRS GENERATE_EXTENSIONS PROTOC_OPTIONS)

  cmake_parse_arguments(protobuf_generate "${_options}" "${_singleargs}" "${_multiargs}" "${ARGN}")

  if(NOT protobuf_generate_PROTOS AND NOT protobuf_generate_TARGET)
    message(SEND_ERROR "Error: protobuf_generate called without any targets or source files")
    return()
  endif()

  if(NOT protobuf_generate_OUT_VAR AND NOT protobuf_generate_TARGET)
    message(SEND_ERROR "Error: protobuf_generate called without a target or output variable")
    return()
  endif()

  if(NOT protobuf_generate_LANGUAGE)
    set(protobuf_generate_LANGUAGE cpp)
  endif()
  string(TOLOWER ${protobuf_generate_LANGUAGE} protobuf_generate_LANGUAGE)

  if(NOT protobuf_generate_PROTOC_OUT_DIR)
    set(protobuf_generate_PROTOC_OUT_DIR ${CMAKE_CURRENT_BINARY_DIR})
  endif()

  if(protobuf_generate_EXPORT_MACRO AND protobuf_generate_LANGUAGE STREQUAL cpp)
    set(_dll_export_decl "dllexport_decl=${protobuf_generate_EXPORT_MACRO}")
  endif()

  foreach(_option ${_dll_export_decl} ${protobuf_generate_PLUGIN_OPTIONS})
    # append comma - not using CMake lists and string replacement as users
    # might have semicolons in options
    if(_plugin_options)
      set( _plugin_options "${_plugin_options},")
    endif()
    set(_plugin_options "${_plugin_options}${_option}")
  endforeach()

  if(protobuf_generate_PLUGIN)
    set(_plugin "--plugin=${protobuf_generate_PLUGIN}")
  endif()

  if(NOT protobuf_generate_GENERATE_EXTENSIONS)
    if(protobuf_generate_LANGUAGE STREQUAL cpp)
      set(protobuf_generate_GENERATE_EXTENSIONS .pb.h .pb.cc)
    elseif(protobuf_generate_LANGUAGE STREQUAL python)
      set(protobuf_generate_GENERATE_EXTENSIONS _pb2.py)
    else()
      message(SEND_ERROR "Error: protobuf_generate given unknown Language ${LANGUAGE}, please provide a value for GENERATE_EXTENSIONS")
      return()
    endif()
  endif()

  if(protobuf_generate_TARGET)
    get_target_property(_source_list ${protobuf_generate_TARGET} SOURCES)
    foreach(_file ${_source_list})
      if(_file MATCHES "proto$")
        list(APPEND protobuf_generate_PROTOS ${_file})
      endif()
    endforeach()
  endif()

  if(NOT protobuf_generate_PROTOS)
    message(SEND_ERROR "Error: protobuf_generate could not find any .proto files")
    return()
  endif()

  if(NOT TARGET protobuf::protoc)
    message(SEND_ERROR "protoc executable not found. "
            "Please define the Protobuf_PROTOC_EXECUTABLE variable or ensure that protoc is in CMake's search path.")
    return()
  endif()

  if(protobuf_generate_APPEND_PATH)
    # Create an include path for each file specified
    foreach(_file ${protobuf_generate_PROTOS})
      get_filename_component(_abs_file ${_file} ABSOLUTE)
      get_filename_component(_abs_dir ${_abs_file} DIRECTORY)
      list(FIND _protobuf_include_path ${_abs_dir} _contains_already)
      if(${_contains_already} EQUAL -1)
          list(APPEND _protobuf_include_path -I ${_abs_dir})
      endif()
    endforeach()
  endif()

  foreach(DIR ${protobuf_generate_IMPORT_DIRS})
    get_filename_component(ABS_PATH ${DIR} ABSOLUTE)
    list(FIND _protobuf_include_path ${ABS_PATH} _contains_already)
    if(${_contains_already} EQUAL -1)
        list(APPEND _protobuf_include_path -I ${ABS_PATH})
    endif()
  endforeach()

  if(NOT protobuf_generate_APPEND_PATH)
    list(APPEND _protobuf_include_path -I ${CMAKE_CURRENT_SOURCE_DIR})
  endif()

  set(_generated_srcs_all)
  foreach(_proto ${protobuf_generate_PROTOS})
    get_filename_component(_abs_file ${_proto} ABSOLUTE)
    get_filename_component(_abs_dir ${_abs_file} DIRECTORY)
    get_filename_component(_basename ${_proto} NAME_WLE)
    file(RELATIVE_PATH _rel_dir ${CMAKE_CURRENT_SOURCE_DIR} ${_abs_dir})

    set(_possible_rel_dir)
    if (NOT protobuf_generate_APPEND_PATH)
      foreach(DIR ${_protobuf_include_path})
        if(NOT DIR STREQUAL "-I")
          file(RELATIVE_PATH _rel_dir ${DIR} ${_abs_dir})
          if(_rel_dir STREQUAL _abs_dir)
            continue()
          endif()
          string(FIND "${_rel_dir}" "../" _is_in_parent_folder)
          if (NOT ${_is_in_parent_folder} EQUAL 0)
            break()
          endif()
        endif()
      endforeach()
      set(_possible_rel_dir ${_rel_dir}/)
    endif()

    set(_generated_srcs)
    foreach(_ext ${protobuf_generate_GENERATE_EXTENSIONS})
      list(APPEND _generated_srcs "${protobuf_generate_PROTOC_OUT_DIR}/${_possible_rel_dir}${_basename}${_ext}")
    endforeach()

    if(protobuf_generate_DESCRIPTORS AND protobuf_generate_LANGUAGE STREQUAL cpp)
      set(_descriptor_file "${CMAKE_CURRENT_BINARY_DIR}/${_basename}.desc")
      set(_dll_desc_out "--descriptor_set_out=${_descriptor_file}")
      list(APPEND _generated_srcs ${_descriptor_file})
    endif()
    list(APPEND _generated_srcs_all ${_generated_srcs})

    set(_comment "Running ${protobuf_generate_LANGUAGE} protocol buffer compiler on ${_proto}")
    if(protobuf_generate_PROTOC_OPTIONS)
      set(_comment "${_comment}, protoc-options: ${protobuf_generate_PROTOC_OPTIONS}")
    endif()
    if(_plugin_options)
      set(_comment "${_comment}, plugin-options: ${_plugin_options}")
    endif()

    add_custom_command(
      OUTPUT ${_generated_srcs}
      COMMAND protobuf::protoc
      ARGS ${protobuf_generate_PROTOC_OPTIONS} --${protobuf_generate_LANGUAGE}_out ${_plugin_options}:${protobuf_generate_PROTOC_OUT_DIR} ${_plugin} ${_dll_desc_out} ${_protobuf_include_path} ${_abs_file}
      DEPENDS ${_abs_file} protobuf::protoc ${protobuf_generate_DEPENDENCIES}
      COMMENT ${_comment}
      VERBATIM )
  endforeach()

  set_source_files_properties(${_generated_srcs_all} PROPERTIES GENERATED TRUE)
  if(protobuf_generate_OUT_VAR)
    set(${protobuf_generate_OUT_VAR} ${_generated_srcs_all} PARENT_SCOPE)
  endif()
  if(protobuf_generate_TARGET)
    target_sources(${protobuf_generate_TARGET} PRIVATE ${_generated_srcs_all})
  endif()
endfunction()

function(PROTOBUF_GENERATE_CPP SRCS HDRS)
  cmake_parse_arguments(protobuf_generate_cpp "" "EXPORT_MACRO;DESCRIPTORS" "" ${ARGN})

  set(_proto_files "${protobuf_generate_cpp_UNPARSED_ARGUMENTS}")
  if(NOT _proto_files)
    message(SEND_ERROR "Error: PROTOBUF_GENERATE_CPP() called without any proto files")
    return()
  endif()

  if(PROTOBUF_GENERATE_CPP_APPEND_PATH)
    set(_append_arg APPEND_PATH)
  endif()

  if(protobuf_generate_cpp_DESCRIPTORS)
    set(_descriptors DESCRIPTORS)
  endif()

  if(DEFINED PROTOBUF_IMPORT_DIRS AND NOT DEFINED Protobuf_IMPORT_DIRS)
    set(Protobuf_IMPORT_DIRS "${PROTOBUF_IMPORT_DIRS}")
  endif()

  if(DEFINED Protobuf_IMPORT_DIRS)
    set(_import_arg IMPORT_DIRS ${Protobuf_IMPORT_DIRS})
  endif()

  set(_outvar)
  protobuf_generate(${_append_arg} ${_descriptors} LANGUAGE cpp EXPORT_MACRO ${protobuf_generate_cpp_EXPORT_MACRO} OUT_VAR _outvar ${_import_arg} PROTOS ${_proto_files})

  set(${SRCS})
  set(${HDRS})
  if(protobuf_generate_cpp_DESCRIPTORS)
    set(${protobuf_generate_cpp_DESCRIPTORS})
  endif()

  foreach(_file ${_outvar})
    if(_file MATCHES "cc$")
      list(APPEND ${SRCS} ${_file})
    elseif(_file MATCHES "desc$")
      list(APPEND ${protobuf_generate_cpp_DESCRIPTORS} ${_file})
    else()
      list(APPEND ${HDRS} ${_file})
    endif()
  endforeach()
  set(${SRCS} ${${SRCS}} PARENT_SCOPE)
  set(${HDRS} ${${HDRS}} PARENT_SCOPE)
  if(protobuf_generate_cpp_DESCRIPTORS)
    set(${protobuf_generate_cpp_DESCRIPTORS} "${${protobuf_generate_cpp_DESCRIPTORS}}" PARENT_SCOPE)
  endif()
endfunction()

function(PROTOBUF_GENERATE_PYTHON SRCS)
  if(NOT ARGN)
    message(SEND_ERROR "Error: PROTOBUF_GENERATE_PYTHON() called without any proto files")
    return()
  endif()

  if(PROTOBUF_GENERATE_CPP_APPEND_PATH)
    set(_append_arg APPEND_PATH)
  endif()

  if(DEFINED PROTOBUF_IMPORT_DIRS AND NOT DEFINED Protobuf_IMPORT_DIRS)
    set(Protobuf_IMPORT_DIRS "${PROTOBUF_IMPORT_DIRS}")
  endif()

  if(DEFINED Protobuf_IMPORT_DIRS)
    set(_import_arg IMPORT_DIRS ${Protobuf_IMPORT_DIRS})
  endif()

  set(_outvar)
  protobuf_generate(${_append_arg} LANGUAGE python OUT_VAR _outvar ${_import_arg} PROTOS ${ARGN})
  set(${SRCS} ${_outvar} PARENT_SCOPE)
endfunction()


if(Protobuf_DEBUG)
  # Output some of their choices
  message(STATUS "[ ${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} ] "
                 "Protobuf_USE_STATIC_LIBS = ${Protobuf_USE_STATIC_LIBS}")
endif()


# Backwards compatibility
# Define camel case versions of input variables
foreach(UPPER
    PROTOBUF_SRC_ROOT_FOLDER
    PROTOBUF_IMPORT_DIRS
    PROTOBUF_DEBUG
    PROTOBUF_LIBRARY
    PROTOBUF_PROTOC_LIBRARY
    PROTOBUF_INCLUDE_DIR
    PROTOBUF_PROTOC_EXECUTABLE
    PROTOBUF_LIBRARY_DEBUG
    PROTOBUF_PROTOC_LIBRARY_DEBUG
    PROTOBUF_LITE_LIBRARY
    PROTOBUF_LITE_LIBRARY_DEBUG
    )
    if (DEFINED ${UPPER})
        string(REPLACE "PROTOBUF_" "Protobuf_" Camel ${UPPER})
        if (NOT DEFINED ${Camel})
            set(${Camel} ${${UPPER}})
        endif()
    endif()
endforeach()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(_PROTOBUF_ARCH_DIR x64/)
endif()


# Internal function: search for normal library as well as a debug one
#    if the debug one is specified also include debug/optimized keywords
#    in *_LIBRARIES variable
function(_protobuf_find_libraries name filename)
  if(${name}_LIBRARIES)
    # Use result recorded by a previous call.
    return()
  elseif(${name}_LIBRARY)
    # Honor cache entry used by CMake 3.5 and lower.
    set(${name}_LIBRARIES "${${name}_LIBRARY}" PARENT_SCOPE)
  else()
    find_library(${name}_LIBRARY_RELEASE
      NAMES ${filename}
      NAMES_PER_DIR
      PATHS ${Protobuf_SRC_ROOT_FOLDER}/vsprojects/${_PROTOBUF_ARCH_DIR}Release)
    mark_as_advanced(${name}_LIBRARY_RELEASE)

    find_library(${name}_LIBRARY_DEBUG
      NAMES ${filename}d ${filename}
      NAMES_PER_DIR
      PATHS ${Protobuf_SRC_ROOT_FOLDER}/vsprojects/${_PROTOBUF_ARCH_DIR}Debug)
    mark_as_advanced(${name}_LIBRARY_DEBUG)

    select_library_configurations(${name})

    if(UNIX AND Threads_FOUND AND ${name}_LIBRARY)
      list(APPEND ${name}_LIBRARIES ${CMAKE_THREAD_LIBS_INIT})
    endif()

    set(${name}_LIBRARY "${${name}_LIBRARY}" PARENT_SCOPE)
    set(${name}_LIBRARIES "${${name}_LIBRARIES}" PARENT_SCOPE)
  endif()
endfunction()

#
# Main.
#

# By default have PROTOBUF_GENERATE_CPP macro pass -I to protoc
# for each directory where a proto file is referenced.
if(NOT DEFINED PROTOBUF_GENERATE_CPP_APPEND_PATH)
  set(PROTOBUF_GENERATE_CPP_APPEND_PATH TRUE)
endif()


if(UNIX)
  # Protobuf headers may depend on threading.
  find_package(Threads QUIET)
endif()

# The Protobuf library
if (EXISTS "${PROJECT_SOURCE_DIR}/../protobuf/src/")
  message (STATUS "Sibling Protobuf found.")
  set (Protobuf_FOUND TRUE)
  set (Protobuf_INCLUDE_DIR
    "${PROJECT_SOURCE_DIR}/../protobuf/src/")
  set (Protobuf_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../protobuf/src/"
    "${PROJECT_BINARY_DIR}/../protobuf/src/")
  set (Protobuf_LIBRARY libprotobuf)
  set (Protobuf_LITE_LIBRARY libprotobuf-lite)
  set (Protobuf_PROTOC_LIBRARY libprotoc)
  set (Protobuf_LIBRARIES
    ${Protobuf_LIBRARY}
    ${Protobuf_LITE_LIBRARY}
    ${Protobuf_PROTOC_LIBRARY})
else ()
  message (STATUS "Sibling Protobuf NOT found.")
endif ()

# Find the protoc Executable
find_program(Protobuf_PROTOC_EXECUTABLE
    NAMES "protoc-${Protobuf_VERSION}"
    DOC "The Google Protocol Buffers Compiler"
    PATHS ENV PATH
    NO_PACKAGE_ROOT_PATH
)
if(NOT Protobuf_PROTOC_EXECUTABLE)
  find_program(Protobuf_PROTOC_EXECUTABLE
    NAMES protoc
    DOC "The Google Protocol Buffers Compiler"
    PATHS ENV PATH
    NO_PACKAGE_ROOT_PATH
  )
endif()

if(Protobuf_DEBUG)
    message(STATUS "[ ${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} ] "
        "requested version of Google Protobuf is ${Protobuf_FIND_VERSION}")
endif()

if(Protobuf_INCLUDE_DIR)
  set(_PROTOBUF_COMMON_HEADER ${Protobuf_INCLUDE_DIR}/google/protobuf/stubs/common.h)

  if(Protobuf_DEBUG)
    message(STATUS "[ ${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} ] "
                   "location of common.h: ${_PROTOBUF_COMMON_HEADER}")
  endif()

  set(Protobuf_VERSION "")
  set(Protobuf_LIB_VERSION "")
  file(STRINGS ${_PROTOBUF_COMMON_HEADER} _PROTOBUF_COMMON_H_CONTENTS REGEX "#define[ \t]+GOOGLE_PROTOBUF_VERSION[ \t]+")
  if(_PROTOBUF_COMMON_H_CONTENTS MATCHES "#define[ \t]+GOOGLE_PROTOBUF_VERSION[ \t]+([0-9]+)")
      set(Protobuf_LIB_VERSION "${CMAKE_MATCH_1}")
  endif()
  unset(_PROTOBUF_COMMON_H_CONTENTS)

  math(EXPR _PROTOBUF_MAJOR_VERSION "${Protobuf_LIB_VERSION} / 1000000")
  math(EXPR _PROTOBUF_MINOR_VERSION "${Protobuf_LIB_VERSION} / 1000 % 1000")
  math(EXPR _PROTOBUF_SUBMINOR_VERSION "${Protobuf_LIB_VERSION} % 1000")
  set(Protobuf_VERSION "${_PROTOBUF_MAJOR_VERSION}.${_PROTOBUF_MINOR_VERSION}.${_PROTOBUF_SUBMINOR_VERSION}")

  if(Protobuf_DEBUG)
    message(STATUS "[ ${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} ] "
        "${_PROTOBUF_COMMON_HEADER} reveals protobuf ${Protobuf_VERSION}")
  endif()

  if(Protobuf_PROTOC_EXECUTABLE)
    # Check Protobuf compiler version to be aligned with libraries version
    execute_process(COMMAND ${Protobuf_PROTOC_EXECUTABLE} --version
                    OUTPUT_VARIABLE _PROTOBUF_PROTOC_EXECUTABLE_VERSION)

    if("${_PROTOBUF_PROTOC_EXECUTABLE_VERSION}" MATCHES "libprotoc ([0-9.]+)")
      set(_PROTOBUF_PROTOC_EXECUTABLE_VERSION "${CMAKE_MATCH_1}")
    endif()

    if(Protobuf_DEBUG)
      message(STATUS "[ ${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} ] "
          "${Protobuf_PROTOC_EXECUTABLE} reveals version ${_PROTOBUF_PROTOC_EXECUTABLE_VERSION}")
    endif()

    # protoc version 22 and up don't print the major version any more
    if(NOT "${_PROTOBUF_PROTOC_EXECUTABLE_VERSION}" VERSION_EQUAL "${Protobuf_VERSION}" AND
       NOT "${_PROTOBUF_PROTOC_EXECUTABLE_VERSION}" VERSION_EQUAL "${_PROTOBUF_MINOR_VERSION}.${_PROTOBUF_SUBMINOR_VERSION}")
      message(WARNING "Protobuf compiler version ${_PROTOBUF_PROTOC_EXECUTABLE_VERSION}"
        " doesn't match library version ${Protobuf_VERSION}")
    endif()
  endif()

  if(Protobuf_LIBRARY)
      if(NOT TARGET protobuf::libprotobuf)
          add_library(protobuf::libprotobuf UNKNOWN IMPORTED)
          set_target_properties(protobuf::libprotobuf PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${Protobuf_INCLUDE_DIR}")
          if(EXISTS "${Protobuf_LIBRARY}")
            set_target_properties(protobuf::libprotobuf PROPERTIES
              IMPORTED_LOCATION "${Protobuf_LIBRARY}")
          endif()
          if(EXISTS "${Protobuf_LIBRARY_RELEASE}")
            set_property(TARGET protobuf::libprotobuf APPEND PROPERTY
              IMPORTED_CONFIGURATIONS RELEASE)
            set_target_properties(protobuf::libprotobuf PROPERTIES
              IMPORTED_LOCATION_RELEASE "${Protobuf_LIBRARY_RELEASE}")
          endif()
          if(EXISTS "${Protobuf_LIBRARY_DEBUG}")
            set_property(TARGET protobuf::libprotobuf APPEND PROPERTY
              IMPORTED_CONFIGURATIONS DEBUG)
            set_target_properties(protobuf::libprotobuf PROPERTIES
              IMPORTED_LOCATION_DEBUG "${Protobuf_LIBRARY_DEBUG}")
          endif()
          if (Protobuf_VERSION VERSION_GREATER_EQUAL "3.6")
            set_property(TARGET protobuf::libprotobuf APPEND PROPERTY
              INTERFACE_COMPILE_FEATURES cxx_std_11
            )
          endif()
          if (WIN32 AND NOT Protobuf_USE_STATIC_LIBS)
            set_property(TARGET protobuf::libprotobuf APPEND PROPERTY
              INTERFACE_COMPILE_DEFINITIONS "PROTOBUF_USE_DLLS"
            )
          endif()
          if(UNIX AND TARGET Threads::Threads)
            set_property(TARGET protobuf::libprotobuf APPEND PROPERTY
                INTERFACE_LINK_LIBRARIES Threads::Threads)
          endif()
      endif()
  endif()

  if(Protobuf_LITE_LIBRARY)
      if(NOT TARGET protobuf::libprotobuf-lite)
          add_library(protobuf::libprotobuf-lite UNKNOWN IMPORTED)
          set_target_properties(protobuf::libprotobuf-lite PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${Protobuf_INCLUDE_DIR}")
          if(EXISTS "${Protobuf_LITE_LIBRARY}")
            set_target_properties(protobuf::libprotobuf-lite PROPERTIES
              IMPORTED_LOCATION "${Protobuf_LITE_LIBRARY}")
          endif()
          if(EXISTS "${Protobuf_LITE_LIBRARY_RELEASE}")
            set_property(TARGET protobuf::libprotobuf-lite APPEND PROPERTY
              IMPORTED_CONFIGURATIONS RELEASE)
            set_target_properties(protobuf::libprotobuf-lite PROPERTIES
              IMPORTED_LOCATION_RELEASE "${Protobuf_LITE_LIBRARY_RELEASE}")
          endif()
          if(EXISTS "${Protobuf_LITE_LIBRARY_DEBUG}")
            set_property(TARGET protobuf::libprotobuf-lite APPEND PROPERTY
              IMPORTED_CONFIGURATIONS DEBUG)
            set_target_properties(protobuf::libprotobuf-lite PROPERTIES
              IMPORTED_LOCATION_DEBUG "${Protobuf_LITE_LIBRARY_DEBUG}")
          endif()
          if (WIN32 AND NOT Protobuf_USE_STATIC_LIBS)
            set_property(TARGET protobuf::libprotobuf-lite APPEND PROPERTY
              INTERFACE_COMPILE_DEFINITIONS "PROTOBUF_USE_DLLS"
            )
          endif()
          if(UNIX AND TARGET Threads::Threads)
            set_property(TARGET protobuf::libprotobuf-lite APPEND PROPERTY
                INTERFACE_LINK_LIBRARIES Threads::Threads)
          endif()
      endif()
  endif()

  if(Protobuf_PROTOC_LIBRARY)
      if(NOT TARGET protobuf::libprotoc)
          add_library(protobuf::libprotoc UNKNOWN IMPORTED)
          set_target_properties(protobuf::libprotoc PROPERTIES
            INTERFACE_INCLUDE_DIRECTORIES "${Protobuf_INCLUDE_DIR}")
          if(EXISTS "${Protobuf_PROTOC_LIBRARY}")
            set_target_properties(protobuf::libprotoc PROPERTIES
              IMPORTED_LOCATION "${Protobuf_PROTOC_LIBRARY}")
          endif()
          if(EXISTS "${Protobuf_PROTOC_LIBRARY_RELEASE}")
            set_property(TARGET protobuf::libprotoc APPEND PROPERTY
              IMPORTED_CONFIGURATIONS RELEASE)
            set_target_properties(protobuf::libprotoc PROPERTIES
              IMPORTED_LOCATION_RELEASE "${Protobuf_PROTOC_LIBRARY_RELEASE}")
          endif()
          if(EXISTS "${Protobuf_PROTOC_LIBRARY_DEBUG}")
            set_property(TARGET protobuf::libprotoc APPEND PROPERTY
              IMPORTED_CONFIGURATIONS DEBUG)
            set_target_properties(protobuf::libprotoc PROPERTIES
              IMPORTED_LOCATION_DEBUG "${Protobuf_PROTOC_LIBRARY_DEBUG}")
          endif()
          if (Protobuf_VERSION VERSION_GREATER_EQUAL "3.6")
            set_property(TARGET protobuf::libprotoc APPEND PROPERTY
              INTERFACE_COMPILE_FEATURES cxx_std_11
            )
          endif()
          if (WIN32 AND NOT Protobuf_USE_STATIC_LIBS)
            set_property(TARGET protobuf::libprotoc APPEND PROPERTY
              INTERFACE_COMPILE_DEFINITIONS "PROTOBUF_USE_DLLS"
            )
          endif()
          if(UNIX AND TARGET Threads::Threads)
            set_property(TARGET protobuf::libprotoc APPEND PROPERTY
                INTERFACE_LINK_LIBRARIES Threads::Threads)
          endif()
      endif()
  endif()

  if(Protobuf_PROTOC_EXECUTABLE)
      if(NOT TARGET protobuf::protoc)
          add_executable(protobuf::protoc IMPORTED)
          if(EXISTS "${Protobuf_PROTOC_EXECUTABLE}")
            set_target_properties(protobuf::protoc PROPERTIES
              IMPORTED_LOCATION "${Protobuf_PROTOC_EXECUTABLE}")
          endif()
      endif()
  endif()
endif()

if(Protobuf_FOUND)
    set(Protobuf_INCLUDE_DIRS ${Protobuf_INCLUDE_DIR})
endif()

# Backwards compatibility
# Define upper case versions of output variables
foreach(Camel
    Protobuf_SRC_ROOT_FOLDER
    Protobuf_IMPORT_DIRS
    Protobuf_DEBUG
    Protobuf_INCLUDE_DIRS
    Protobuf_LIBRARIES
    Protobuf_PROTOC_LIBRARIES
    Protobuf_LITE_LIBRARIES
    Protobuf_LIBRARY
    Protobuf_PROTOC_LIBRARY
    Protobuf_INCLUDE_DIR
    Protobuf_PROTOC_EXECUTABLE
    Protobuf_LIBRARY_DEBUG
    Protobuf_PROTOC_LIBRARY_DEBUG
    Protobuf_LITE_LIBRARY
    Protobuf_LITE_LIBRARY_DEBUG
    )
    string(TOUPPER ${Camel} UPPER)
    set(${UPPER} ${${Camel}})
endforeach()

cmake_policy(POP)
