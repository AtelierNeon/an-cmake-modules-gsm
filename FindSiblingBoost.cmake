if (EXISTS "${PROJECT_SOURCE_DIR}/../boost/libs/")
  message (STATUS "Sibling Boost found.")
  set (Boost_FOUND TRUE)
  set (Boost_INCLUDE_DIRS
    "${PROJECT_SOURCE_DIR}/../boost/libs/algorithm/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/any/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/assert/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/bind/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/chrono/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/compute/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/config/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/container_hash/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/core/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/date_time/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/detail/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/dll/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/filesystem/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/foreach/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/functional/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/integer/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/io/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/iterator/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/lexical_cast/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/math/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/move/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/mpl/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/multi_index/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/numeric/conversion/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/optional/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/predef/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/property_tree/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/preprocessor/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/random/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/range/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/ratio/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/serialization/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/smart_ptr/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/static_assert/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/system/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/thread/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/throw_exception/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/tuple/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/type_index/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/type_traits/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/unordered/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/utility/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/locale/include/"
    "${PROJECT_SOURCE_DIR}/../boost/libs/winapi/include/")
  set (Boost_ALGORITHM_LIBRARY boost_algorithm)
  set (Boost_ANY_LIBRARY boost_any)
  set (Boost_ASSERT_LIBRARY boost_assert)
  set (Boost_BIND_LIBRARY boost_bind)
  set (Boost_CHRONO_LIBRARY boost_chrono)
  #set (Boost_COMPUTE_LIBRARY boost_compute)
  set (Boost_CONFIG_LIBRARY boost_config)
  set (Boost_CONTAINER_HASH_LIBRARY boost_container_hash)
  set (Boost_CORE_LIBRARY boost_core)
  set (Boost_DATE_TIME_LIBRARY boost_date_time)
  set (Boost_DETAIL_LIBRARY boost_detail)
  set (Boost_FILESYSTEM_LIBRARY boost_filesystem)
  set (Boost_FUNCTIONAL_LIBRARY boost_functional)
  set (Boost_INTEGER_LIBRARY boost_integer)
  set (Boost_IO_LIBRARY boost_io)
  set (Boost_ITERATOR_LIBRARY boost_iterator)
  set (Boost_LEXICAL_CAST_LIBRARY boost_lexical_cast)
  set (Boost_MATH_LIBRARY boost_math)
  set (Boost_MPL_LIBRARY boost_mpl)
  set (Boost_MOVE_LIBRARY boost_move)
  set (Boost_NUMERIC_CONVERSION_LIBRARY boost_numeric_conversion)
  set (Boost_OPTIONAL_LIBRARY boost_optional)
  set (Boost_PREDEF_LIBRARY boost_predef)
  set (Boost_PREPROCESSOR_LIBRARY boost_preprocessor)
  set (Boost_RANDOM_LIBRARY boost_random)
  set (Boost_RANGE_LIBRARY boost_range)
  set (Boost_RATIO_LIBRARY boost_ratio)
  set (Boost_SMART_PTR_LIBRARY boost_smart_ptr)
  set (Boost_STATIC_ASSERT_LIBRARY boost_static_assert)
  set (Boost_SYSTEM_LIBRARY boost_system)
  set (Boost_THREAD_LIBRARY boost_thread)
  set (Boost_THROW_EXCEPTION_LIBRARY boost_throw_exception)
  set (Boost_TUPLE_LIBRARY boost_tuple)
  set (Boost_TYPE_INDEX_LIBRARY boost_type_index)
  set (Boost_TYPE_TRAITS_LIBRARY boost_type_traits)
  set (Boost_UNORDERED_LIBRARY boost_unordered)
  set (Boost_UTILITY_LIBRARY boost_utility)
  set (Boost_LOCALE_LIBRARY boost_locale)
  set (Boost_WINAPI_LIBRARY boost_winapi)
  set (Boost_LIBRARIES
    ${Boost_ALGORITHM_LIBRARY}
    ${Boost_ANY_LIBRARY}
    ${Boost_ASSERT_LIBRARY}
    ${Boost_BIND_LIBRARY}
    ${Boost_CHRONO_LIBRARY}
    #${Boost_COMPUTE_LIBRARY}
    ${Boost_CONFIG_LIBRARY}
    ${Boost_CONTAINER_HASH_LIBRARY}
    ${Boost_CORE_LIBRARY}
    ${Boost_DATE_TIME_LIBRARY}
    ${Boost_DETAIL_LIBRARY}
    ${Boost_FILESYSTEM_LIBRARY}
    ${Boost_FUNCTIONAL_LIBRARY}
    ${Boost_INTEGER_LIBRARY}
    ${Boost_IO_LIBRARY}
    ${Boost_ITERATOR_LIBRARY}
    ${Boost_LEXICAL_CAST_LIBRARY}
    ${Boost_MATH_LIBRARY}
    ${Boost_MPL_LIBRARY}
    ${Boost_NUMERIC_CONVERSION_LIBRARY}
    ${Boost_OPTIONAL_LIBRARY}
    ${Boost_PREPROCESSOR_LIBRARY}
    ${Boost_RANDOM_LIBRARY}
    ${Boost_RANGE_LIBRARY}
    ${Boost_RATIO_LIBRARY}
    ${Boost_SMART_PTR_LIBRARY}
    ${Boost_STATIC_ASSERT_LIBRARY}
    ${Boost_SYSTEM_LIBRARY}
    ${Boost_THREAD_LIBRARY}
    ${Boost_THROW_EXCEPTION_LIBRARY}
    ${Boost_TUPLE_LIBRARY}
    ${Boost_TYPE_TRAITS_LIBRARY}
    ${Boost_UNORDERED_LIBRARY}
    ${Boost_UTILITY_LIBRARY}
    ${Boost_LOCALE_LIBRARY}
    ${Boost_WINAPI_LIBRARY})
else()
  message (STATUS "Sibling Boost NOT found.")
endif ()

