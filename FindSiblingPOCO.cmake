if (EXISTS "${PROJECT_SOURCE_DIR}/../poco/")
  message (STATUS "Sibling POCO found.")
  set (POCO_FOUND TRUE)
  set (POCO_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../poco/Crypto/include/"
    "${PROJECT_SOURCE_DIR}/../poco/Data/include/"
    "${PROJECT_SOURCE_DIR}/../poco/Foundation/include/"
    "${PROJECT_SOURCE_DIR}/../poco/Net/include/"
    "${PROJECT_SOURCE_DIR}/../poco/Util/include/")
  set (POCO_Foundation_LIBRARY PocoFoundation)
  set (POCO_Net_LIBRARY PocoNet)
  set (POCO_Util_LIBRARY PocoUtil)
  set (POCO_LIBRARIES
    ${POCO_Foundation_LIBRARY}
    ${POCO_Net_LIBRARY}
    ${POCO_Util_LIBRARY})
else ()
  message (STATUS "Sibling POCO NOT found.")
endif ()
