if (EXISTS "${PROJECT_SOURCE_DIR}/../libxml2/include/")
  set (LIBXML2_FOUND TRUE)
  set (LIBXML2_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../libxml2/include/"
    "${PROJECT_BINARY_DIR}/../libxml2/")
elseif (EXISTS "${PROJECT_SOURCE_DIR}/../../libxml2/include/")
  set (LIBXML2_FOUND TRUE)
  set (LIBXML2_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../../libxml2/include/"
    "${PROJECT_BINARY_DIR}/../../libxml2/")
elseif (EXISTS "${PROJECT_SOURCE_DIR}/../../../libxml2/include/")
  set (LIBXML2_FOUND TRUE)
  set (LIBXML2_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../../../libxml2/include/"
    "${PROJECT_BINARY_DIR}/../../../libxml2/")
elseif (EXISTS "${PROJECT_SOURCE_DIR}/../../../../libxml2/include/")
  set (LIBXML2_FOUND TRUE)
  set (LIBXML2_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../../../../libxml2/include/"
    "${PROJECT_BINARY_DIR}/../../../../libxml2/")
endif ()

if (LIBXML2_FOUND)
  message (STATUS "Sibling LibXML2 found.")
  set (LIBXML2_LIBRARY LibXml2)
  set (LIBXML2_LIBRARIES ${LIBXML2_LIBRARY})
  if (NOT TARGET LibXml2::LibXml2)
    if (NOT TARGET ${LIBXML2_LIBRARY})
      message (WARNING "Target ${LIBXML2_LIBRARY} is NOT FOUND. You should include LibXML2 as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${LIBXML2_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${LIBXML2_INCLUDE_DIRS}")
      add_library (LibXml2::LibXml2 ALIAS ${LIBXML2_LIBRARY})
    endif()
  endif ()
else ()
  message (STATUS "Sibling LibXML2 NOT found.")
endif ()

if (LIBXML2_INCLUDE_DIRS AND NOT LIBXML2_INCLUDE_DIR)
  set (LIBXML2_INCLUDE_DIR ${LIBXML2_INCLUDE_DIRS})
endif ()
