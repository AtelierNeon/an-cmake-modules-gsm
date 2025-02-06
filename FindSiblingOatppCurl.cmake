if (EXISTS "${PROJECT_SOURCE_DIR}/../oatpp-curl/src/")
  message (STATUS "Sibling oatpp-curl found.")
  set (OATPP_CURL_FOUND TRUE)
  set (OATPP_CURL_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../oatpp-curl/src/"
    "${PROJECT_BINARY_DIR}/../oatpp-curl/src/")
  set (OATPP_CURL_LIBRARY oatpp-curl)
  set (OATPP_CURL_LIBRARIES ${OATPP_CURL_LIBRARY})
else ()
  message (STATUS "Sibling oatpp-curl NOT found.")
endif ()

if (OATPP_CURL_FOUND)
  if (NOT TARGET oatpp::oatpp-curl)
    if (NOT TARGET ${OATPP_CURL_LIBRARY})
      message (WARNING "Target ${OATPP_CURL_LIBRARY} is NOT FOUND. You should include oatpp-curl as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${OATPP_CURL_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OATPP_CURL_INCLUDE_DIRS}")
      add_library (oatpp::oatpp-curl ALIAS ${OATPP_CURL_LIBRARY})
    endif ()
  endif ()
endif ()

if (OATPP_CURL_INCLUDE_DIRS AND NOT OATPP_CURL_INCLUDE_DIR)
  set (OATPP_CURL_INCLUDE_DIR ${OATPP_CURL_INCLUDE_DIRS})
endif ()
