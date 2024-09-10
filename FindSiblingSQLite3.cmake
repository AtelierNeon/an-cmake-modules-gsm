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
