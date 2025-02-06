if (EXISTS "${PROJECT_SOURCE_DIR}/../oatpp-websocket/src/")
  message (STATUS "Sibling oatpp-websocket found.")
  set (OATPP_WEBSOCKET_FOUND TRUE)
  set (OATPP_WEBSOCKET_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../oatpp-websocket/src/"
    "${PROJECT_BINARY_DIR}/../oatpp-websocket/src/")
  set (OATPP_WEBSOCKET_LIBRARY oatpp-websocket)
  set (OATPP_WEBSOCKET_LIBRARIES ${OATPP_WEBSOCKET_LIBRARY})
else ()
  message (STATUS "Sibling oatpp-websocket NOT found.")
endif ()

if (OATPP_WEBSOCKET_FOUND)
  if (NOT TARGET oatpp::oatpp-websocket)
    if (NOT TARGET ${OATPP_WEBSOCKET_LIBRARY})
      message (WARNING "Target ${OATPP_WEBSOCKET_LIBRARY} is NOT FOUND. You should include oatpp-websocket as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${OATPP_WEBSOCKET_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${OATPP_WEBSOCKET_INCLUDE_DIRS}")
      add_library (oatpp::oatpp-websocket ALIAS ${OATPP_WEBSOCKET_LIBRARY})
    endif ()
  endif ()
endif ()

if (OATPP_WEBSOCKET_INCLUDE_DIRS AND NOT OATPP_WEBSOCKET_INCLUDE_DIR)
  set (OATPP_WEBSOCKET_INCLUDE_DIR ${OATPP_WEBSOCKET_INCLUDE_DIRS})
endif ()
