

project( dataframe )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### dataframe
set(EP_dataframe "dataframe_git")
ExternalProject_Add(${EP_dataframe}
    PREFIX ${EP_dataframe}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #SOURCE_DIR ${${EP_dataframe}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/dataframe.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)

include(debuglog)
