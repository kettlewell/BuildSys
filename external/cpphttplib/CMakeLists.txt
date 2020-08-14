

project( armadillo )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### armadillo
set(EP_armadillo "armadillo_git")
ExternalProject_Add(${EP_armadillo}
    PREFIX ${EP_armadillo}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    SOURCE_DIR ${${EP_armadillo}_SOURCE_DIR}  # Provided by FetchContent
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    DEPENDS boost_git openblas_git lapack_git
)

include(debuglog)
