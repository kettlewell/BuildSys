

project( nlohmannjson )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### nlohmannjson
set(EP_nlohmannjson "nlohmannjson_git")
ExternalProject_Add(${EP_nlohmannjson}
    PREFIX ${EP_nlohmannjson}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #SOURCE_DIR ${${EP_nlohmannjson}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/nlohmannjson.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)

include(debuglog)
