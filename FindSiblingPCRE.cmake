if (EXISTS "${PROJECT_SOURCE_DIR}/../pcre/")
  message (STATUS "Sibling PCRE found.")
  set (PCRE_FOUND TRUE)
  set (PCRE_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../pcre/"
    "${PROJECT_BINARY_DIR}/../pcre/")
  set (PCRE_LIBRARY pcre)
  set (PCRE_LIBRARIES ${PCRE_LIBRARY})
  if (NOT PCRE_WITH_SHARED_LIBRARIES)
    add_definitions(-DPCRE_STATIC)
  endif ()
else ()
  message (STATUS "Sibling PCRE NOT found.")
endif ()
