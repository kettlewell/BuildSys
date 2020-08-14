

project( rapidjson )

#list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(enter)

include(ExternalProject)

### rapidjson
set(EP_rapidjson "rapidjson_git")
ExternalProject_Add(${EP_rapidjson}
    PREFIX ${EP_rapidjson}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #SOURCE_DIR ${${EP_rapidjson}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/rapidjson.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DRAPIDJSON_BUILD_DOC:BOOL=OFF
        -DRAPIDJSON_BUILD_EXAMPLES:BOOL=OFF
        -DRAPIDJSON_BUILD_TESTS:BOOL=OFF
        -DRAPIDJSON_BUILD_THIRDPARTY_GTEST:BOOL=OFF
        -DRAPIDJSON_BUILD_CXX11:BOOL=ON
        -DRAPIDJSON_BUILD_ASAN:BOOL=OFF
        -DRAPIDJSON_BUILD_UBSAN:BOOL=OFF
        -DRAPIDJSON_ENABLE_INSTRUMENTATION_OPT:BOOL=ON
        -DRAPIDJSON_HAS_STDSTRING:BOOL=OFF
)

#include(debuglog)
include(exit)
