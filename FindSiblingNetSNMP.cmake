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
