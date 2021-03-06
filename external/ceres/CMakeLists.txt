

project( ceres )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

message(STATUS "BS_CERES_GFLAGS: ${BS_CERES_GFLAGS}")
message(STATUS "BS_CERES_MINIGLOG: ${BS_CERES_MINIGLOG}")

### ceres
set(EP_ceres "ceres_git")
ExternalProject_Add(${EP_ceres}
    PREFIX ${EP_ceres}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    # SOURCE_DIR ${${EP_ceres}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/ceres.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DGFLAGS:BOOL=${BS_CERES_GFLAGS} 
        -DMINIGLOG:BOOL=${BS_CERES_MINIGLOG} 
        -DCMAKE_CXX_STANDARD:STRING=${BS_CERES_CMAKE_CXX_STANDARD}
        -DCERES_THREADING_MODEL:STRING=${BS_CERES_CERES_THREADING_MODEL}
        -DBUILD_TESTING:BOOL=${BS_CERES_BUILD_TESTING}
        -DBUILD_EXAMPLES:BOOL=${BS_CERES_BUILD_EXAMPLES}
        -DBUILD_BENCHMARKS:BOOL=${BS_CERES_BUILD_BENCHMARKS}
        -DLIB_SUFFIX:STRING=${BS_CERES_LIB_SUFFIX}
        -DBUILD_SHARED_LIBS:BOOL=${BS_CERES_BUILD_SHARED_LIBS}
        -DSUITESPARSE:BOOL=${BS_CERES_SUITESPARSE}
        -DCXSPARSE:BOOL=${BS_CERES_CXSPARSE}
    DEPENDS eigen_git lapack_git openblas_git
)

include(debuglog)
