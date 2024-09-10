if (EXISTS "${PROJECT_SOURCE_DIR}/../expat/lib/")
  message (STATUS "Sibling expat found.")
  set (EXPAT_FOUND TRUE)
  set (EXPAT_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../expat/lib/"
    "${PROJECT_BINARY_DIR}/../expat/lib/")
  set (EXPAT_LIBRARY expat)
  set (EXPAT_LIBRARIES ${EXPAT_LIBRARY})
else ()
  message (STATUS "Sibling expat NOT found.")
endif ()
