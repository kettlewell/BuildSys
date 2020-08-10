

project( eigen )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### eigen
set(EP_eigen "eigen_git")
ExternalProject_Add(${EP_eigen}
    PREFIX ${EP_eigen}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    SOURCE_DIR ${${EP_eigen}_SOURCE_DIR}  # Provided by FetchContent
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)

include(debuglog)
