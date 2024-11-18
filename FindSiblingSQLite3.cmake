if (EXISTS "${PROJECT_SOURCE_DIR}/../sqlite/")
  message (STATUS "Sibling SQLite3 found.")
  set (SQLITE3_FOUND TRUE)
  set (SQLITE3_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../sqlite/"
    "${PROJECT_BINARY_DIR}/../sqlite/")
  set (SQLITE3_LIBRARY sqlite)
  set (SQLITE3_LIBRARIES ${SQLITE3_LIBRARY})
else ()
  message (STATUS "Sibling SQLite3 NOT found.")
endif ()

if (SQLITE3_FOUND)
  if (NOT TARGET SQLite::SQLite3)
    if (NOT TARGET ${SQLITE3_LIBRARY})
      message (WARNING "Target ${SQLITE3_LIBRARY} is NOT FOUND. You should include SQLite3 as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${SQLITE3_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${SQLITE3_INCLUDE_DIRS}")
      add_library (SQLite::SQLite3 ALIAS ${SQLITE3_LIBRARY})
    endif ()
  endif ()
endif ()

if (SQLITE3_INCLUDE_DIRS AND NOT SQLITE3_INCLUDE_DIR)
  set (SQLITE3_INCLUDE_DIR ${SQLITE3_INCLUDE_DIRS})
endif ()
