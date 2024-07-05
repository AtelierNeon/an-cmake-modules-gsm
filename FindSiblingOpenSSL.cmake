## Check which version exists and is preferred
if (EXISTS "${PROJECT_SOURCE_DIR}/../openssl-1_1_1/include/" AND BUILD_WITH_OPENSSL_1_1_1_PREFERRED)
  set (_OPENSSL_1_1_1_FOUND TRUE)
elseif (EXISTS "${PROJECT_SOURCE_DIR}/../openssl-3_0/include/" AND BUILD_WITH_OPENSSL_3_0_PREFERRED)
  set (_OPENSSL_3_0_FOUND TRUE)
else ()
  if (EXISTS "${PROJECT_SOURCE_DIR}/../openssl/include/")
    set (_OPENSSL_FOUND TRUE)
  elseif (EXISTS "${PROJECT_SOURCE_DIR}/../openssl-1_1_1/include/")
    set (_OPENSSL_1_1_1_FOUND TRUE)
  elseif (EXISTS "${PROJECT_SOURCE_DIR}/../openssl-3_0/include/")
    set (_OPENSSL_3_0_FOUND TRUE)
  endif ()
endif ()

## Use the checked version
if (_OPENSSL_1_1_1_FOUND)
  message (STATUS "Sibling OpenSSL 1.1.1 found.")
  set (OPENSSL_FOUND TRUE)
  set (OPENSSL_1_1_1_FOUND TRUE)
  set (OPENSSL_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../openssl-1_1_1/include/"
    "${PROJECT_BINARY_DIR}/../openssl-1_1_1/include/")
  set (OPENSSL_CRYPTO_LIBRARY crypto)
  set (OPENSSL_SSL_LIBRARY ssl)
  set (OPENSSL_LIBRARIES
    ${OPENSSL_CRYPTO_LIBRARY}
    ${OPENSSL_SSL_LIBRARY})
elseif (_OPENSSL_3_0_FOUND)
  message (STATUS "Sibling OpenSSL 3.0 found.")
  set (OPENSSL_FOUND TRUE)
  set (OPENSSL_3_0_FOUND TRUE)
  set (OPENSSL_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../openssl-3_0/include/"
    "${PROJECT_BINARY_DIR}/../openssl-3_0/include/")
  set (OPENSSL_CRYPTO_LIBRARY crypto)
  set (OPENSSL_SSL_LIBRARY ssl)
  set (OPENSSL_LIBRARIES
    ${OPENSSL_CRYPTO_LIBRARY}
    ${OPENSSL_SSL_LIBRARY})
elseif (_OPENSSL_FOUND)
  message (STATUS "Sibling OpenSSL found.")
  set (OPENSSL_FOUND TRUE)
  set (OPENSSL_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../openssl/include/"
    "${PROJECT_BINARY_DIR}/../openssl/include/")
  set (OPENSSL_CRYPTO_LIBRARY crypto)
  set (OPENSSL_SSL_LIBRARY ssl)
  set (OPENSSL_LIBRARIES
    ${OPENSSL_CRYPTO_LIBRARY}
    ${OPENSSL_SSL_LIBRARY})
  message (STATUS "Checking Sibling OpenSSL version.")
  if (EXISTS "${PROJECT_SOURCE_DIR}/../openssl/include/openssl/opensslv.h")
    file(READ "${PROJECT_SOURCE_DIR}/../openssl/include/openssl/opensslv.h" OPENSSL_VERSION)
    string(FIND "${OPENSSL_VERSION}" "OpenSSL 1.1.1" match_1_1_1)
    if(${match_1_1_1} GREATER_EQUAL 0)
      message (STATUS "Checking Sibling OpenSSL version. - 1.1.1")
      set (OPENSSL_1_1_1_FOUND TRUE)
    endif ()
  endif ()
  if (EXISTS "${PROJECT_SOURCE_DIR}/../openssl/VERSION.dat")
    file(READ "${PROJECT_SOURCE_DIR}/../openssl/VERSION.dat" OPENSSL_VERSION)
    string(FIND "${OPENSSL_VERSION}" "MAJOR=3" match_major3)
    string(FIND "${OPENSSL_VERSION}" "MINOR=0" match_minor0)
    if(${match_major3} GREATER_EQUAL 0)
      if(${match_minor0} GREATER_EQUAL 0)
        message (STATUS "Checking Sibling OpenSSL version. - 3.0")
        set (OPENSSL_3_0_FOUND TRUE)
      endif ()
    endif ()
  endif ()
else ()
  message (STATUS "Sibling OpenSSL NOT found.")
endif ()

## Cleanup
unset (_OPENSSL_1_1_1_FOUND)
unset (_OPENSSL_3_0_FOUND)
unset (_OPENSSL_FOUND)
