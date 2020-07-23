# Top Level CMAKE File
cmake_minimum_required(VERSION 3.14)

project(subprojects)

# TODO: 
#       remove policy deprecation warnings
#       enhance messages... still unclear on a few items.
#       create entrance and exit messages

# Why does this work here, and not below... or does it... ?
set(CMAKE_VERBOSE_MAKEFILE ON)

# Add the project cmake path
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# cmakepp is a cmake library of "things"
# TODO: make use of these functions
#include(installcmakepp)


# TODO:  used? Not in the top level ... 
# Parallelize build if possible
#include(ProcessorCount)
#ProcessorCount(NJOBS)
#if(NJOBS EQUAL 0)
#  set(NJOBS 2)
#endif()


set(CONFIG_BUILD_TYPE "Release" CACHE PATH "CONFIG_BUILD_TYPE" FORCE)
set(INSTALL_BASE "/data/opt" CACHE PATH "INSTALL BASE" FORCE)
set(CMAKE_FIND_ROOT_PATH ${INSTALL_BASE} CACHE PATH "CMAKE_FIND_ROOT_PATH" FORCE)
set(CMAKE_INSTALL_PREFIX ${INSTALL_BASE} CACHE PATH "CMAKE_INSTALL_PREFIX" FORCE)
set(CMAKE_BUILD_TYPE ${CONFIG_BUILD_TYPE} CACHE PATH "CMAKE_BUILD_TYPE" FORCE)

# Why does this not work here, but does up above ?
set(CMAKE_VERBOSE_MAKEFILE:BOOL=ON)
set(CMAKE_RULE_MESSAGES:BOOL=ON)

#set (CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install CACHE PATH "Cmake prefix" FORCE) 
## Add a custom CMake Modules directory
#set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/modules ${CMAKE_MODULE_PATH})
#set(CMAKE_MODULE_PATH /data/opt/cmake/modules ${CMAKE_MODULE_PATH})
# Set a default build type if none was specified
set(default_build_type "Release")



if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
  set(CMAKE_BUILD_TYPE ${default_build_type} CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()


# Globally Set Compiler Options for c++11
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)

# check results and add flag
if(COMPILER_SUPPORTS_CXX11)#
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif(COMPILER_SUPPORTS_CXX0X)#
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else()
    message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

include(FetchAndPopulate)

FetchAndPopulate(
    rapidjson
    https://github.com/Tencent/rapidjson
    master
)
FetchAndPopulate(
    lapack
    https://github.com/Reference-LAPACK/lapack.git
    v3.9.0
)

FetchAndPopulate(
    boost
    /data/git/boost.git
    boost-1.73.0
)

FetchAndPopulate(
    openblas
    /data/git/OpenBLAS.git
    develop
)

# Needs to be set in dependency order
add_subdirectory(${CMAKE_SOURCE_DIR}/external/rapidjson)
add_subdirectory(${CMAKE_SOURCE_DIR}/external/boost)
add_subdirectory(${CMAKE_SOURCE_DIR}/external/openblas)
add_subdirectory(${CMAKE_SOURCE_DIR}/external/lapack)



# Fetch Contents
#include(FetchContent)


# Rapid JSON
#FetchContent_Declare(
#    rapidjson
#    GIT_REPOSITORY https://github.com/Tencent/rapidjson
#    GIT_TAG master
#)
#FetchContent_GetProperties(rapidjson)
#if(NOT rapidjson_POPULATED)
#    FetchContent_Populate(rapidjson)
#endif()

#BOOST.Build
#FetchContent_Declare(
#    boostbuild
#    GIT_REPOSITORY https://github.com/boostorg/build.git
#    GIT_TAG develop
#)
#FetchContent_GetProperties(boostbuild)
#if(NOT boostbuild_POPULATED)
#    FetchContent_Populate(boostbuild)
#endif()

#BOOST
#FetchContent_Declare(
#    boost_git
#    #GIT_REPOSITORY https://github.com/boostorg/boost.git
#    GIT_REPOSITORY /data/git/boost
#    GIT_TAG boost-1.73.0
#    GIT_CONFIG jobs=10
#)
#FetchContent_GetProperties(boost_git)
#if(NOT boost_git_POPULATED)
#    FetchContent_Populate(boost_git)
#endif()


###lapack
#FetchContent_Declare(
#    lapack_git
#    GIT_REPOSITORY https://github.com/Reference-LAPACK/lapack.git
#    GIT_TAG v3.9.0
#)
#FetchContent_GetProperties(lapack_git)
#if(NOT lapack_git_POPULATED)
#    FetchContent_Populate(lapack_git)
#endif()


include(debuglog)


## External Projects
#include(ExternalProject)

# RapidJSON
#set(EP_rapidjson "rapidjson")
#ExternalProject_Add(${EP_rapidjson}
#    PREFIX ${EP_rapidjson}
#    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
#    SOURCE_DIR ${${EP_rapidjson}_SOURCE_DIR}  # Provided by FetchContent
#    CMAKE_CACHE_DEFAULT_ARGS
#        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE}
#        -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
#        -DRAPIDJSON_BUILD_DOC:BOOL=OFF
#        -DRAPIDJSON_BUILD_EXAMPLES:BOOL=OFF
#        -DRAPIDJSON_BUILD_TESTS:BOOL=OFF
#        -DRAPIDJSON_BUILD_THIRDPARTY_GTEST:BOOL=OFF
#        -DRAPIDJSON_BUILD_CXX11:BOOL=ON
#        -DRAPIDJSON_BUILD_ASAN:BOOL=OFF
#        -DRAPIDJSON_BUILD_UBSAN:BOOL=OFF
#        -DRAPIDJSON_ENABLE_INSTRUMENTATION_OPT:BOOL=ON
#        -DRAPIDJSON_HAS_STDSTRING:BOOL=OFF
#    DEPENDS boost
#)





# for calling internal project with the external commands:

# https://chromium.googlesource.com/external/github.com/grpc/grpc/+/HEAD/examples/cpp/helloworld/cmake_externalproject/CMakeLists.txt
# Build the helloworld projects itself using a CMakeLists.txt that assumes all the dependencies
# have already been installed.
# Even though helloworld is not really an "external project" from perspective of this build,
# we are still importing it using ExternalProject_Add because that allows us to use find_package()
# to locate all the dependencies (if we were building helloworld directly in this build we,
# we would have needed to manually import the libraries as opposed to reusing targets exported by
# gRPC and protobuf).

#ExternalProject_Add(helloworld
#  PREFIX helloworld
#  SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/.."
#  BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/helloworld"
#  INSTALL_COMMAND ""
#  CMAKE_CACHE_ARGS
#        -DProtobuf_DIR:PATH=${_FINDPACKAGE_PROTOBUF_CONFIG_DIR}
#        -Dc-ares_DIR:PATH=${CMAKE_CURRENT_BINARY_DIR}/c-ares/lib/cmake/c-ares
#        -Dre2_DIR:STRING=${CMAKE_CURRENT_BINARY_DIR}/re2/lib/cmake/re2
#        -DZLIB_ROOT:STRING=${CMAKE_CURRENT_BINARY_DIR}/zlib
#        -Dabsl_DIR:STRING=${CMAKE_CURRENT_BINARY_DIR}/absl/lib/cmake/absl
#        ${_CMAKE_ARGS_OPENSSL_ROOT_DIR}
#        -DgRPC_DIR:PATH=${CMAKE_CURRENT_BINARY_DIR}/grpc/lib/cmake/grpc
#  DEPENDS protobuf grpc
#)



## Instead of adding sub_directory() calls, I think I have to create my projects as an externalproject ( and just point to the src )




## TODO:  Configure later
## STATIC ANALYSIS

# find the cppcheck binary
#find_package(CppCheck)

# static analysis. Should be before adding subprojects
#set (ALL_ANALYSIS_TARGETS)


# Add the "make analysis" target (after add_subdirectory calls)
#if( CPPCHECK_FOUND )
#    add_custom_target(analysis)
#    ADD_DEPENDENCIES(analysis ${ALL_ANALYSIS_TARGETS})
#    set_target_properties(analysis PROPERTIES EXCLUDE_FROM_ALL TRUE)
#    message("analysis analysis targets are ${ALL_ANALYSIS_TARGETS}")
#endif()
