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

if (EXPAT_FOUND)
  if (NOT TARGET EXPAT::EXPAT)
    if (NOT TARGET ${EXPAT_LIBRARY})
      message (WARNING "Target ${EXPAT_LIBRARY} is NOT FOUND. You should include expat as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${EXPAT_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${EXPAT_INCLUDE_DIRS}")
      add_library (EXPAT::EXPAT ALIAS ${EXPAT_LIBRARY})
    endif ()
  endif ()
endif ()

if (EXPAT_INCLUDE_DIRS AND NOT EXPAT_INCLUDE_DIR)
  set (EXPAT_INCLUDE_DIR ${EXPAT_INCLUDE_DIRS})
endif ()
