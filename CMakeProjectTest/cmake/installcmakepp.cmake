

include(FetchContent)

FetchContent_Declare(
    cmakepp
    GIT_REPOSITORY /data/git/cmakepp.git
    GIT_TAG master
)
FetchContent_GetProperties(cmakepp)
if(NOT cmakepp_POPULATED)
    FetchContent_Populate(cmakepp)
endif()

# include dependencies for cmakepp
include(CheckCXXSourceCompiles)
include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckLibraryExists)

# set policy for version to work
#cmake_policy(SET CMP0048 NEW)

include(debuglog)
include(${cmakepp_SOURCE_DIR}/cmakepp.cmake)
