if (EXISTS "${PROJECT_SOURCE_DIR}/../net-snmp/include/")
  message (STATUS "Sibling Net-SNMP found.")
  set (NETSNMP_FOUND TRUE)
  set (NETSNMP_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../net-snmp/include/"
    "${PROJECT_BINARY_DIR}/../net-snmp/include/")
  set (NETSNMP_LIBRARY netsnmp)
  set (NETSNMP_LIBRARIES ${NETSNMP_LIBRARY})
else ()
  message (STATUS "Sibling Net-SNMP NOT found.")
endif ()

if (NETSNMP_FOUND)
  if (NOT TARGET NetSNMP::NetSNMP)
    if (NOT TARGET ${NETSNMP_LIBRARY})
      message (WARNING "Target ${NETSNMP_LIBRARY} is NOT FOUND. You should include Net-SNMP as sibling library before ${PROJECT_NAME}.")
    else ()
      set_target_properties(${NETSNMP_LIBRARY} PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${NETSNMP_INCLUDE_DIRS}")
      add_library (NetSNMP::NetSNMP ALIAS ${NETSNMP_LIBRARY})
    endif ()
  endif ()
endif ()

if (NETSNMP_INCLUDE_DIRS AND NOT NETSNMP_INCLUDE_DIR)
  set (NETSNMP_INCLUDE_DIR ${NETSNMP_INCLUDE_DIRS})
endif ()
