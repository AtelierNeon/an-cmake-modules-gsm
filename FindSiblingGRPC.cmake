if (EXISTS "${PROJECT_SOURCE_DIR}/../grpc/include/")
  message (STATUS "Sibling GRPC found.")
  set (GRPC_FOUND TRUE)
  set (GRPC_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../grpc/include/")
  set (GRPC_GRPC_LIBRARY grpc)
  set (GRPC_GRPCPP_LIBRARY grpc++)
  set (GRPC_GPR_LIBRARY gpr)
  set (GRPC_LIBRARIES
    ${GRPC_GRPC_LIBRARY}
    ${GRPC_GRPCPP_LIBRARY}
    ${GRPC_GPR_LIBRARY})
else()
  message (STATUS "Sibling GRPC NOT found.")
endif ()

if (GRPC_INCLUDE_DIRS AND NOT GRPC_INCLUDE_DIR)
  set (GRPC_INCLUDE_DIR ${GRPC_INCLUDE_DIRS})
endif ()
