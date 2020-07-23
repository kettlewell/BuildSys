

project( lapack )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### lapack
set(EP_lapack "lapack_git")
ExternalProject_Add(${EP_lapack}
    PREFIX ${EP_lapack}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    SOURCE_DIR ${${EP_lapack}_SOURCE_DIR}  # Provided by FetchContent
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DUSE_OPTIMIZED_BLAS:BOOL=ON 
        -DBUILD_SHARED_LIBS:BOOL=ON
    DEPENDS boost_git openblas_git
)

include(debuglog)
