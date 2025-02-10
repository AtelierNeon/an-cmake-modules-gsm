if (EXISTS "${PROJECT_SOURCE_DIR}/../abseil-cpp/")
  message (STATUS "Sibling ABSL found.")
  set (ABSL_FOUND TRUE)
  set (ABSL_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../abseil-cpp/")
else()
  message (STATUS "Sibling ABSL NOT found.")
endif ()

if (ABSL_INCLUDE_DIRS AND NOT ABSL_INCLUDE_DIR)
  set (ABSL_INCLUDE_DIR ${ABSL_INCLUDE_DIRS})
endif ()
