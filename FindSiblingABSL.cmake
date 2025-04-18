if (EXISTS "${PROJECT_SOURCE_DIR}/../abseil-cpp/")
  message (STATUS "Sibling ABSL found.")
  set (ABSL_FOUND TRUE)
  set (ABSL_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../abseil-cpp/")
  set (ABSL_BAD_ANY_CAST_IMPL_LIBRARY absl_bad_any_cast_impl)
  set (ABSL_BAD_OPTIONAL_ACCESS_LIBRARY absl_bad_optional_access)
  set (ABSL_BAD_VARIANT_ACCESS_LIBRARY absl_bad_variant_access)
  set (ABSL_BASE_LIBRARY absl_base)
  set (ABSL_CITY_LIBRARY absl_city)
  set (ABSL_CIVIL_TIME_LIBRARY absl_civil_time)
  set (ABSL_CORD_INTERNAL_LIBRARY absl_cord_internal)
  set (ABSL_CORD_LIBRARY absl_cord)
  set (ABSL_CORDZ_FUNCTIONS_LIBRARY absl_cordz_functions)
  set (ABSL_CORDZ_HANDLE_LIBRARY absl_cordz_handle)
  set (ABSL_CORDZ_INFO_LIBRARY absl_cordz_info)
  set (ABSL_CORDZ_SAMPLE_TOKEN_LIBRARY absl_cordz_sample_token)
  set (ABSL_CRC_CORD_STATE_LIBRARY absl_crc_cord_state)
  set (ABSL_CRC_CPU_DETECT_LIBRARY absl_crc_cpu_detect)
  set (ABSL_CRC_INTERNAL_LIBRARY absl_crc_internal)
  set (ABSL_CRC32C_LIBRARY absl_crc32c)
  set (ABSL_DEBUGGING_INTERNAL_LIBRARY absl_debugging_internal)
  set (ABSL_DEMANGLE_INTERNAL_LIBRARY absl_demangle_internal)
  set (ABSL_DIE_IF_NULL_LIBRARY absl_die_if_null)
  set (ABSL_EXAMINE_STACK_LIBRARY absl_examine_stack)
  set (ABSL_EXPONENTIAL_BIASED_LIBRARY absl_exponential_biased)
  set (ABSL_FAILURE_SIGNAL_HANDLER_LIBRARY absl_failure_signal_handler)
  set (ABSL_FLAGS_COMMANDLINEFLAG_INTERNAL_LIBRARY absl_flags_commandlineflag_internal)
  set (ABSL_FLAGS_COMMANDLINEFLAG_LIBRARY absl_flags_commandlineflag)
  set (ABSL_FLAGS_CONFIG_LIBRARY absl_flags_config)
  set (ABSL_FLAGS_INTERNAL_LIBRARY absl_flags_internal)
  set (ABSL_FLAGS_LIBRARY absl_flags)
  set (ABSL_FLAGS_MARSHALLING_LIBRARY absl_flags_marshalling)
  set (ABSL_FLAGS_PARSE_LIBRARY absl_flags_parse)
  set (ABSL_FLAGS_PRIVATE_HANDLE_ACCESSOR_LIBRARY absl_flags_private_handle_accessor)
  set (ABSL_FLAGS_PROGRAM_NAME_LIBRARY absl_flags_program_name)
  set (ABSL_FLAGS_REFLECTION_LIBRARY absl_flags_reflection)
  set (ABSL_FLAGS_USAGE_INTERNAL_LIBRARY absl_flags_usage_internal)
  set (ABSL_FLAGS_USAGE_LIBRARY absl_flags_usage)
  set (ABSL_GRAPHCYCLES_INTERNAL_LIBRARY absl_graphcycles_internal)
  set (ABSL_HASH_LIBRARY absl_hash)
  set (ABSL_HASHTABLEZ_SAMPLER_LIBRARY absl_hashtablez_sampler)
  set (ABSL_INT128_LIBRARY absl_int128)
  set (ABSL_LEAK_CHECK_LIBRARY absl_leak_check)
  set (ABSL_LOG_ENTRY_LIBRARY absl_log_entry)
  set (ABSL_LOG_FLAGS_LIBRARY absl_log_flags)
  set (ABSL_LOG_GLOBALS_LIBRARY absl_log_globals)
  set (ABSL_LOG_INITIALIZE_LIBRARY absl_log_initialize)
  set (ABSL_LOG_INTERNAL_CHECK_OP_LIBRARY absl_log_internal_check_op)
  set (ABSL_LOG_INTERNAL_CONDITIONS_LIBRARY absl_log_internal_conditions)
  set (ABSL_LOG_INTERNAL_FORMAT_LIBRARY absl_log_internal_format)
  set (ABSL_LOG_INTERNAL_GLOBALS_LIBRARY absl_log_internal_globals)
  set (ABSL_LOG_INTERNAL_LOG_SINK_SET_LIBRARY absl_log_internal_log_sink_set)
  set (ABSL_LOG_INTERNAL_MESSAGE_LIBRARY absl_log_internal_message)
  set (ABSL_LOG_INTERNAL_NULLGUARD_LIBRARY absl_log_internal_nullguard)
  set (ABSL_LOG_INTERNAL_PROTO_LIBRARY absl_log_internal_proto)
  set (ABSL_LOG_SEVERITY_LIBRARY absl_log_severity)
  set (ABSL_LOG_SINK_LIBRARY absl_log_sink)
  set (ABSL_LOW_LEVEL_HASH_LIBRARY absl_low_level_hash)
  set (ABSL_MALLOC_INTERNAL_LIBRARY absl_malloc_internal)
  set (ABSL_PERIODIC_SAMPLER_LIBRARY absl_periodic_sampler)
  set (ABSL_RANDOM_DISTRIBUTIONS_LIBRARY absl_random_distributions)
  set (ABSL_RANDOM_INTERNAL_DISTRIBUTION_TEST_UTIL_LIBRARY absl_random_internal_distribution_test_util)
  set (ABSL_RANDOM_INTERNAL_PLATFORM_LIBRARY absl_random_internal_platform)
  set (ABSL_RANDOM_INTERNAL_POOL_URBG_LIBRARY absl_random_internal_pool_urbg)
  set (ABSL_RANDOM_INTERNAL_RANDEN_HWAES_IMPL_LIBRARY absl_random_internal_randen_hwaes_impl)
  set (ABSL_RANDOM_INTERNAL_RANDEN_HWAES_LIBRARY absl_random_internal_randen_hwaes)
  set (ABSL_RANDOM_INTERNAL_RANDEN_LIBRARY absl_random_internal_randen)
  set (ABSL_RANDOM_INTERNAL_RANDEN_SLOW_LIBRARY absl_random_internal_randen_slow)
  set (ABSL_RANDOM_INTERNAL_SEED_MATERIAL_LIBRARY absl_random_internal_seed_material)
  set (ABSL_RANDOM_SEED_GEN_EXCEPTION_LIBRARY absl_random_seed_gen_exception)
  set (ABSL_RANDOM_SEED_SEQUENCES_LIBRARY absl_random_seed_sequences)
  set (ABSL_RAW_HASH_SET_LIBRARY absl_raw_hash_set)
  set (ABSL_RAW_LOGGING_INTERNAL_LIBRARY absl_raw_logging_internal)
  set (ABSL_SCOPED_SET_ENV_LIBRARY absl_scoped_set_env)
  set (ABSL_SPINLOCK_WAIT_LIBRARY absl_spinlock_wait)
  set (ABSL_STACKTRACE_LIBRARY absl_stacktrace)
  set (ABSL_STATUS_LIBRARY absl_status)
  set (ABSL_STATUSOR_LIBRARY absl_statusor)
  set (ABSL_STR_FORMAT_INTERNAL_LIBRARY absl_str_format_internal)
  set (ABSL_STRERROR_LIBRARY absl_strerror)
  set (ABSL_STRINGS_INTERNAL_LIBRARY absl_strings_internal)
  set (ABSL_STRINGS_LIBRARY absl_strings)
  set (ABSL_SYMBOLIZE_LIBRARY absl_symbolize)
  set (ABSL_SYNCHRONIZATION_LIBRARY absl_synchronization)
  set (ABSL_THROW_DELEGATE_LIBRARY absl_throw_delegate)
  set (ABSL_TIME_LIBRARY absl_time)
  set (ABSL_TIME_ZONE_LIBRARY absl_time_zone)
  set (ABSL_LIBRARIES
    ${ABSL_BAD_ANY_CAST_IMPL_LIBRARY}
    ${ABSL_BAD_OPTIONAL_ACCESS_LIBRARY}
    ${ABSL_BAD_VARIANT_ACCESS_LIBRARY}
    ${ABSL_BASE_LIBRARY}
    ${ABSL_CITY_LIBRARY}
    ${ABSL_CIVIL_TIME_LIBRARY}
    ${ABSL_CORD_INTERNAL_LIBRARY}
    ${ABSL_CORD_LIBRARY}
    ${ABSL_CORDZ_FUNCTIONS_LIBRARY}
    ${ABSL_CORDZ_HANDLE_LIBRARY}
    ${ABSL_CORDZ_INFO_LIBRARY}
    ${ABSL_CORDZ_SAMPLE_TOKEN_LIBRARY}
    ${ABSL_CRC_CORD_STATE_LIBRARY}
    ${ABSL_CRC_CPU_DETECT_LIBRARY}
    ${ABSL_CRC_INTERNAL_LIBRARY}
    ${ABSL_CRC32C_LIBRARY}
    ${ABSL_DEBUGGING_INTERNAL_LIBRARY}
    ${ABSL_DEMANGLE_INTERNAL_LIBRARY}
    ${ABSL_DIE_IF_NULL_LIBRARY}
    ${ABSL_EXAMINE_STACK_LIBRARY}
    ${ABSL_EXPONENTIAL_BIASED_LIBRARY}
    ${ABSL_FAILURE_SIGNAL_HANDLER_LIBRARY}
    ${ABSL_FLAGS_COMMANDLINEFLAG_INTERNAL_LIBRARY}
    ${ABSL_FLAGS_COMMANDLINEFLAG_LIBRARY}
    ${ABSL_FLAGS_CONFIG_LIBRARY}
    ${ABSL_FLAGS_INTERNAL_LIBRARY}
    ${ABSL_FLAGS_LIBRARY}
    ${ABSL_FLAGS_MARSHALLING_LIBRARY}
    ${ABSL_FLAGS_PARSE_LIBRARY}
    ${ABSL_FLAGS_PRIVATE_HANDLE_ACCESSOR_LIBRARY}
    ${ABSL_FLAGS_PROGRAM_NAME_LIBRARY}
    ${ABSL_FLAGS_REFLECTION_LIBRARY}
    ${ABSL_FLAGS_USAGE_INTERNAL_LIBRARY}
    ${ABSL_FLAGS_USAGE_LIBRARY}
    ${ABSL_GRAPHCYCLES_INTERNAL_LIBRARY}
    ${ABSL_HASH_LIBRARY}
    ${ABSL_HASHTABLEZ_SAMPLER_LIBRARY}
    ${ABSL_INT128_LIBRARY}
    ${ABSL_LEAK_CHECK_LIBRARY}
    ${ABSL_LOG_ENTRY_LIBRARY}
    ${ABSL_LOG_FLAGS_LIBRARY}
    ${ABSL_LOG_GLOBALS_LIBRARY}
    ${ABSL_LOG_INITIALIZE_LIBRARY}
    ${ABSL_LOG_INTERNAL_CHECK_OP_LIBRARY}
    ${ABSL_LOG_INTERNAL_CONDITIONS_LIBRARY}
    ${ABSL_LOG_INTERNAL_FORMAT_LIBRARY}
    ${ABSL_LOG_INTERNAL_GLOBALS_LIBRARY}
    ${ABSL_LOG_INTERNAL_LOG_SINK_SET_LIBRARY}
    ${ABSL_LOG_INTERNAL_MESSAGE_LIBRARY}
    ${ABSL_LOG_INTERNAL_NULLGUARD_LIBRARY}
    ${ABSL_LOG_INTERNAL_PROTO_LIBRARY}
    ${ABSL_LOG_SEVERITY_LIBRARY}
    ${ABSL_LOG_SINK_LIBRARY}
    ${ABSL_LOW_LEVEL_HASH_LIBRARY}
    ${ABSL_MALLOC_INTERNAL_LIBRARY}
    ${ABSL_PERIODIC_SAMPLER_LIBRARY}
    ${ABSL_RANDOM_DISTRIBUTIONS_LIBRARY}
    ${ABSL_RANDOM_INTERNAL_DISTRIBUTION_TEST_UTIL_LIBRARY}
    ${ABSL_RANDOM_INTERNAL_PLATFORM_LIBRARY}
    ${ABSL_RANDOM_INTERNAL_POOL_URBG_LIBRARY}
    ${ABSL_RANDOM_INTERNAL_RANDEN_HWAES_IMPL_LIBRARY}
    ${ABSL_RANDOM_INTERNAL_RANDEN_HWAES_LIBRARY}
    ${ABSL_RANDOM_INTERNAL_RANDEN_LIBRARY}
    ${ABSL_RANDOM_INTERNAL_RANDEN_SLOW_LIBRARY}
    ${ABSL_RANDOM_INTERNAL_SEED_MATERIAL_LIBRARY}
    ${ABSL_RANDOM_SEED_GEN_EXCEPTION_LIBRARY}
    ${ABSL_RANDOM_SEED_SEQUENCES_LIBRARY}
    ${ABSL_RAW_HASH_SET_LIBRARY}
    ${ABSL_RAW_LOGGING_INTERNAL_LIBRARY}
    ${ABSL_SCOPED_SET_ENV_LIBRARY}
    ${ABSL_SPINLOCK_WAIT_LIBRARY}
    ${ABSL_STACKTRACE_LIBRARY}
    ${ABSL_STATUS_LIBRARY}
    ${ABSL_STATUSOR_LIBRARY}
    ${ABSL_STR_FORMAT_INTERNAL_LIBRARY}
    ${ABSL_STRERROR_LIBRARY}
    ${ABSL_STRINGS_INTERNAL_LIBRARY}
    ${ABSL_STRINGS_LIBRARY}
    ${ABSL_SYMBOLIZE_LIBRARY}
    ${ABSL_SYNCHRONIZATION_LIBRARY}
    ${ABSL_THROW_DELEGATE_LIBRARY}
    ${ABSL_TIME_LIBRARY}
    ${ABSL_TIME_ZONE_LIBRARY})
else()
  message (STATUS "Sibling ABSL NOT found.")
endif ()

if (ABSL_INCLUDE_DIRS AND NOT ABSL_INCLUDE_DIR)
  set (ABSL_INCLUDE_DIR ${ABSL_INCLUDE_DIRS})
endif ()
