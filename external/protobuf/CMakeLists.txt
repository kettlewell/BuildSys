

project( protobuf )
#list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(enter)


include(ProcessorCount)
set(NPROCS 4)
ProcessorCount(_NPROCS)
if (${_NPROCS})
  set ( NPROCS ${_NPROCS} )
endif()

include(ExternalProject)


### protobuf
set(EP_protobuf "protobuf_git")
ExternalProject_Add(${EP_protobuf}
    PREFIX ${EP_protobuf}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    # SOURCE_DIR ${${EP_protobuf}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/protobuf.git
    GIT_TAG  master
    BUILD_IN_SOURCE 1
    PATCH_COMMAND  ""
    CONFIGURE_COMMAND <SOURCE_DIR>/autogen.sh 
    COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
    BUILD_COMMAND make PREFIX=<INSTALL_DIR> -j${NPROCS} -d
    INSTALL_COMMAND make install PREFIX=<INSTALL_DIR> -d
    LOG_DOWNLOAD ON
    LOG_UPDATE ON
    LOG_CONFIGURE ON
    LOG_BUILD ON
    LOG_INSTALL ON
    WORKING_DIRECTORY <SOURCE_DIR>
)

include(debuglog)
include(exit)
