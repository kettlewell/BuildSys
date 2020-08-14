

project( blaze )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### blaze
set(EP_blaze "blaze_git")
ExternalProject_Add(${EP_blaze}
    PREFIX ${EP_blaze}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    # SOURCE_DIR ${${EP_blaze}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/blaze.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    DEPENDS openmpi_git lapack_git
)

include(debuglog)
