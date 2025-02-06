if (EXISTS "${PROJECT_SOURCE_DIR}/../oatpp-openssl/src/")
  message (STATUS "Sibling oatpp-openssl found.")
  set (OATPP_OPENSSL_FOUND TRUE)
  set (OATPP_OPENSSL_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../oatpp-openssl/src/"
    "${PROJECT_BINARY_DIR}/../oatpp-openssl/src/")
  set (OATPP_OPENSSL_LIBRARY oatpp-openssl)
  set (OATPP_OPENSSL_LIBRARIES ${OATPP_OPENSSL_LIBRARY})
else ()
  message (STATUS "Sibling oatpp-openssl NOT found.")
endif ()

if (OATPP_OPENSSL_FOUND)
  if (NOT TARGET oatpp::oatpp-openssl)
    if (NOT TARGET ${OATPP_OPENSSL_LIBRARY})
      message (WARNING "Target ${OATPP_OPENSSL_LIBRARY} is NOT FOUND. You should include oatpp-openssl as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${OATPP_OPENSSL_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OATPP_OPENSSL_INCLUDE_DIRS}")
      add_library (oatpp::oatpp-openssl ALIAS ${OATPP_OPENSSL_LIBRARY})
    endif ()
  endif ()
endif ()

if (OATPP_OPENSSL_INCLUDE_DIRS AND NOT OATPP_OPENSSL_INCLUDE_DIR)
  set (OATPP_OPENSSL_INCLUDE_DIR ${OATPP_OPENSSL_INCLUDE_DIRS})
endif ()
