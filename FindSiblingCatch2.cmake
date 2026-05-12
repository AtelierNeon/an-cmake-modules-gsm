if (EXISTS "${PROJECT_SOURCE_DIR}/../catch2/include/")
  message (STATUS "Sibling Catch2 found.")
  set (CATCH2_FOUND TRUE)
  set (CATCH2_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../catch2/include/"
    "${PROJECT_BINARY_DIR}/../catch2/include/")
  set (CATCH2_LIBRARY Catch2)
  set (CATCH2_LIBRARIES ${CATCH2_LIBRARY})
else ()
  message (STATUS "Sibling Catch2 NOT found.")
endif ()

if (CATCH2_FOUND)
  if (NOT TARGET Catch2::Catch2)
    if (NOT TARGET ${CATCH2_LIBRARY})
      message (WARNING "Target ${CATCH2_LIBRARY} is NOT FOUND. You should include catch2 as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${CATCH2_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${CATCH2_INCLUDE_DIRS}")
      add_library (Catch2::Catch2 ALIAS ${CATCH2_LIBRARY})
    endif ()
  endif ()
endif ()

if (CATCH2_INCLUDE_DIRS AND NOT CATCH2_INCLUDE_DIR)
  set (CATCH2_INCLUDE_DIR ${CATCH2_INCLUDE_DIRS})
endif ()
