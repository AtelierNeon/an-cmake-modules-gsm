if (EXISTS "${PROJECT_SOURCE_DIR}/../oatpp/src/")
  message (STATUS "Sibling oatpp found.")
  set (OATPP_FOUND TRUE)
  set (OATPP_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../oatpp/src/"
    "${PROJECT_BINARY_DIR}/../oatpp/src/")
  set (OATPP_LIBRARY oatpp)
  set (OATPP_LIBRARIES ${OATPP_LIBRARY})
  if (EXISTS "${PROJECT_SOURCE_DIR}/../oatpp/test/")
    message (STATUS "Sibling oatpp-test found.")
    set (OATPP_TEST_FOUND TRUE)
    set (OATPP_TEST_INCLUDE_DIRS
      "${PROJECT_SOURCE_DIR}/../oatpp/test/"
      "${PROJECT_BINARY_DIR}/../oatpp/test/")
    set (OATPP_TEST_LIBRARY oatpp-test)
    set (OATPP_TEST_LIBRARIES ${OATPP_TEST_LIBRARY})
  else ()
    message (STATUS "Sibling oatpp-test NOT found.")
  endif ()
else ()
  message (STATUS "Sibling oatpp NOT found.")
endif ()

if (OATPP_FOUND)
  if (NOT TARGET oatpp::oatpp)
    if (NOT TARGET ${OATPP_LIBRARY})
      message (WARNING "Target ${OATPP_LIBRARY} is NOT FOUND. You should include oatpp as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${OATPP_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OATPP_INCLUDE_DIRS}")
      add_library (oatpp::oatpp ALIAS ${OATPP_LIBRARY})
    endif ()
  endif ()
  if (OATPP_TEST_FOUND)
    if (NOT TARGET oatpp::oatpp-test)
      if (NOT TARGET ${OATPP_TEST_LIBRARY})
        message (WARNING "Target ${OATPP_TEST_LIBRARY} is NOT FOUND. You should include oatpp as sibling library before ${PROJECT_NAME}.")
      else ()
        set_target_properties(${OATPP_TEST_LIBRARY} PROPERTIES
          INTERFACE_INCLUDE_DIRECTORIES "${OATPP_TEST_INCLUDE_DIRS}")
        add_library (oatpp::oatpp-test ALIAS ${OATPP_TEST_LIBRARY})
      endif ()
    endif ()
  endif ()
endif ()

if (OATPP_INCLUDE_DIRS AND NOT OATPP_INCLUDE_DIR)
  set (OATPP_INCLUDE_DIR ${OATPP_INCLUDE_DIRS})
endif ()
