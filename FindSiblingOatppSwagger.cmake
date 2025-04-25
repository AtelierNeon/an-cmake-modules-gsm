if (EXISTS "${PROJECT_SOURCE_DIR}/../oatpp-swagger/src/")
  message (STATUS "Sibling oatpp-swagger found.")
  set (OATPP_SWAGGER_FOUND TRUE)
  set (OATPP_SWAGGER_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../oatpp-swagger/src/"
    "${PROJECT_BINARY_DIR}/../oatpp-swagger/src/")
  set (OATPP_SWAGGER_RESOURCE_DIR "${PROJECT_SOURCE_DIR}/../oatpp-swagger/res/")
  set (OATPP_SWAGGER_LIBRARY oatpp-swagger)
  set (OATPP_SWAGGER_LIBRARIES ${OATPP_SWAGGER_LIBRARY})
else ()
  message (STATUS "Sibling oatpp-swagger NOT found.")
endif ()

if (OATPP_SWAGGER_FOUND)
  if (NOT TARGET oatpp::oatpp-swagger)
    if (NOT TARGET ${OATPP_SWAGGER_LIBRARY})
      message (WARNING "Target ${OATPP_SWAGGER_LIBRARY} is NOT FOUND. You should include oatpp-swagger as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${OATPP_SWAGGER_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OATPP_SWAGGER_INCLUDE_DIRS}")
      add_library (oatpp::oatpp-swagger ALIAS ${OATPP_SWAGGER_LIBRARY})
    endif ()
  endif ()
endif ()

if (OATPP_SWAGGER_INCLUDE_DIRS AND NOT OATPP_SWAGGER_INCLUDE_DIR)
  set (OATPP_SWAGGER_INCLUDE_DIR ${OATPP_SWAGGER_INCLUDE_DIRS})
endif ()
