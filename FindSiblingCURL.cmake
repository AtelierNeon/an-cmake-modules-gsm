if (EXISTS "${PROJECT_SOURCE_DIR}/../curl/include/")
  message (STATUS "Sibling CURL found.")
  set (CURL_FOUND TRUE)
  set (CURL_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../curl/include/"
    "${PROJECT_BINARY_DIR}/../curl/include/")
  set (CURL_LIBRARY libcurl)
  set (CURL_LIBRARIES ${CURL_LIBRARY})
else ()
  message (STATUS "Sibling CURL NOT found.")
endif ()
