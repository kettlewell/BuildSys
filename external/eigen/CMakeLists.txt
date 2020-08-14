

project( eigen )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### eigen
set(EP_eigen "eigen_git")
ExternalProject_Add(${EP_eigen}
    PREFIX ${EP_eigen}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #SOURCE_DIR ${${EP_eigen}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/eigen.git
    GIT_TAG  3.3.7
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
    DEPENDS boost_git openblas_git lapack_git
)

include(debuglog)
