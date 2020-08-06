# Fetch, Populate, and add Sudirectory
#
# Input:
#     NAME - is the subdirectory name
#     REPO - git repository name
#     TAG  - git tag / branch
#
# Other:
#     GITNAME - the subdir name with '_git' appended
#
# Usage:
#      FetchAndPopulate(
#                       boost
#                       /data/opt/boost.git
#                       develop
#                       )
#
include(FetchContent)

macro(FetchAndPopulate NAME REPO TAG)
    message( STATUS "   Fetching " ${NAME} )
    set(GITNAME ${NAME}_git)
    FetchContent_Declare(
        ${GITNAME}
        GIT_REPOSITORY ${REPO}
        GIT_TAG ${TAG}
    )
    FetchContent_GetProperties(${GITNAME})
        if(NOT ${GITNAME}_POPULATED)
            FetchContent_Populate(${GITNAME})
            # add_subdirectory(${CMAKE_SOURCE_DIR}/external/${NAME})
    endif()
endmacro()
