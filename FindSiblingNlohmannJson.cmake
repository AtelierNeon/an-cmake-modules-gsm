if (EXISTS "${PROJECT_SOURCE_DIR}/../nlohmann-json/include/")
  message (STATUS "Sibling nlohmann/json found.")
  set (NLOHMANN_JSON_FOUND TRUE)
  set (NLOHMANN_JSON_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../nlohmann-json/include/"
    "${PROJECT_BINARY_DIR}/../nlohmann-json/include/")
  set (NLOHMANN_JSON_LIBRARY nlohmann_json)
  set (NLOHMANN_JSON_LIBRARIES ${NLOHMANN_JSON_LIBRARY})
else ()
  message (STATUS "Sibling nlohmann/json NOT found.")
endif ()

if (NLOHMANN_JSON_FOUND)
  if (NOT TARGET nlohmann_json::nlohmann_json)
    if (NOT TARGET ${NLOHMANN_JSON_LIBRARY})
      message (WARNING "Target ${NLOHMANN_JSON_LIBRARY} is NOT FOUND. You should include nlohmann/json as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${NLOHMANN_JSON_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${NLOHMANN_JSON_INCLUDE_DIRS}")
      add_library (nlohmann_json::nlohmann_json ALIAS ${NLOHMANN_JSON_LIBRARY})
    endif ()
  endif ()
endif ()

if (NLOHMANN_JSON_INCLUDE_DIRS AND NOT NLOHMANN_JSON_INCLUDE_DIR)
  set (NLOHMANN_JSON_INCLUDE_DIR ${NLOHMANN_JSON_INCLUDE_DIRS})
endif ()
