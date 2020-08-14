

project( shark )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### shark
set(EP_shark "shark_git")
ExternalProject_Add(${EP_shark}
    PREFIX ${EP_shark}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    # SOURCE_DIR ${${EP_shark}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/shark.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    DEPENDS boost_git   openblas_git 
)

include(debuglog)

#DEPENDS boost_git openmpi_git openblas_git lapack_git
