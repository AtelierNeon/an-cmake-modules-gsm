if (EXISTS "${PROJECT_SOURCE_DIR}/../quazip/quazip/")
  message (STATUS "Sibling QuaZIP found.")
  set (QUAZIP_FOUND TRUE)
  set (QUAZIP_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../quazip/quazip/"
    "${PROJECT_BINARY_DIR}/../quazip/quazip/")
  set (QUAZIP_LIBRARY QuaZip)
  set (QUAZIP_LIBRARIES ${QUAZIP_LIBRARY})
else ()
  message (STATUS "Sibling QuaZIP NOT found.")
endif ()

if (QUAZIP_FOUND)
  if (NOT TARGET QuaZip::QuaZip)
    if (NOT TARGET ${QUAZIP_LIBRARY})
      message (WARNING "Target ${QUAZIP_LIBRARY} is NOT FOUND. You should include QuaZIP as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${QUAZIP_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${QUAZIP_INCLUDE_DIRS}")
      add_library (QuaZip::QuaZip ALIAS ${QUAZIP_LIBRARY})
    endif ()
  endif ()
endif ()

if (QUAZIP_INCLUDE_DIRS AND NOT QUAZIP_INCLUDE_DIR)
  set (QUAZIP_INCLUDE_DIR ${QUAZIP_INCLUDE_DIRS})
endif ()
