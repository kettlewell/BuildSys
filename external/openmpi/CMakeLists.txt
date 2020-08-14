

project( openmpi )
#list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(enter)


include(ProcessorCount)
set(NPROCS 4)
ProcessorCount(_NPROCS)
if (${_NPROCS})
  set ( NPROCS ${_NPROCS} )
endif()

include(ExternalProject)


### openmpi
set(EP_openmpi "openmpi_git")
ExternalProject_Add(${EP_openmpi}
    PREFIX ${EP_openmpi}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #SOURCE_DIR ${${EP_openmpi}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/openmpi.git
    GIT_TAG  master
    BUILD_IN_SOURCE 1
    PATCH_COMMAND  ""
    CONFIGURE_COMMAND <SOURCE_DIR>/autogen.pl -j=${NPROCS} -d
    COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> --disable-picky --disable-man-pages
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
