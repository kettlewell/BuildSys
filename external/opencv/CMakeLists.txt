

project( opencv )

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

include(ExternalProject)

### opencv
set(EP_opencv "opencv_git")
ExternalProject_Add(${EP_opencv}
    PREFIX ${EP_opencv}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    # SOURCE_DIR ${${EP_opencv}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/opencv.git
    GIT_TAG  master
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
)

include(debuglog)
