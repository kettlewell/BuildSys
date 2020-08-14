

project( jemalloc )
#list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(enter)


include(ProcessorCount)
set(NPROCS 4)
ProcessorCount(_NPROCS)
if (${_NPROCS})
  set ( NPROCS ${_NPROCS} )
endif()

include(ExternalProject)


### jemalloc
set(EP_jemalloc "jemalloc_git")
ExternalProject_Add(${EP_jemalloc}
    PREFIX ${EP_jemalloc}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #SOURCE_DIR ${${EP_jemalloc}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/jemalloc.git
    GIT_TAG  master
    BUILD_IN_SOURCE 1
    PATCH_COMMAND  ""
    CONFIGURE_COMMAND <SOURCE_DIR>/autogen.sh 
    COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --with-jemalloc-prefix=je_
    BUILD_COMMAND make  -j${NPROCS} -d
    INSTALL_COMMAND make install -d
    LOG_DOWNLOAD ON
    LOG_UPDATE ON
    LOG_CONFIGURE ON
    LOG_BUILD ON
    LOG_INSTALL ON
    WORKING_DIRECTORY <SOURCE_DIR>
)

include(debuglog)
include(exit)
