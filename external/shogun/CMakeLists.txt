

project( shogun )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### shogun
set(EP_shogun "shogun_git")
ExternalProject_Add(${EP_shogun}
    PREFIX ${EP_shogun}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    # SOURCE_DIR ${${EP_shogun}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/shogun.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    DEPENDS boost_git eigen_git
)

include(debuglog)
