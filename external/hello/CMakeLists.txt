# Set the project name
project (hello_proj)

cmake_minimum_required(VERSION 3.17)

#list(APPEND CMAKE_MODULE_PATH ${CMAKE_INSTALL_PREFIX})

include(ExternalProject)

### hello
set(EP_hello "hello")

ExternalProject_Add(${EP_hello}
    PREFIX ${EP_hello}
    #BUILD_ALWAYS 1
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    SOURCE_DIR ${${EP_hello}_SOURCE_DIR}  # Provided by FetchContent
    CMAKE_CACHE_DEFAULT_ARGS
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        -DCMAKE_MODULE_PATH:PATH=${CMAKE_MODULE_PATH}
    DEPENDS boost_git openblas_git rapidjson_git lapack_git
)


#ExternalProject_Get_property(hello SOURCE_DIR BINARY_DIR)
#message("Source dir of hello = ${SOURCE_DIR}")
#message("Binary dir of hello = ${BINARY_DIR}")

include(debuglog)