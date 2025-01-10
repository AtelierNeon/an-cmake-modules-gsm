if (EXISTS "${PROJECT_SOURCE_DIR}/../libssh2/include/")
  message (STATUS "Sibling libssh2 found.")
  set (LIBSSH2_FOUND TRUE)
  set (LIBSSH2_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../libssh2/include/"
    "${PROJECT_BINARY_DIR}/../libssh2/")
  set (LIBSSH2_LIBRARY libssh2_shared)
  if (LIBSSH2_USE_STATIC_LIBS)
    message (STATUS "Using static sibling LibSSH2.")
    set (LIBSSH2_LIBRARY libssh2_static)
  else ()
    message (STATUS "Using shared sibling LibSSH2.")
  endif ()
  set (LIBSSH2_LIBRARIES ${LIBSSH2_LIBRARY})
else ()
  message (STATUS "Sibling libssh2 NOT found.")
endif ()

if (LIBSSH2_INCLUDE_DIRS AND NOT LIBSSH2_INCLUDE_DIR)
  set (LIBSSH2_INCLUDE_DIR ${LIBSSH2_INCLUDE_DIRS})
endif ()
