

project( ensmallen )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### ensmallen
set(EP_ensmallen "ensmallen_git")
ExternalProject_Add(${EP_ensmallen}
    PREFIX ${EP_ensmallen}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    # SOURCE_DIR ${${EP_ensmallen}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/ensmallen.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    DEPENDS boost_git armadillo_git
)

include(debuglog)
