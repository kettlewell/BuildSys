# Top Level CMAKE File
cmake_minimum_required(VERSION 3.14)

project(buildsys)

# TODO: 
#       remove policy deprecation warnings
#       enhance messages... still unclear on a few items.
#       create entrance and exit messages


# Add the project cmake path
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# cmakepp is a cmake library of "things"
# TODO: make use of these functions
#include(installcmakepp)

# TODO: Cleanup this variable mess ... 
set(CONFIG_BUILD_TYPE        "Release"              CACHE STRING "CONFIG_BUILD_TYPE"    )
set(INSTALL_BASE             "/data/opt"            CACHE PATH "INSTALL BASE"         )
set(CMAKE_FIND_ROOT_PATH     "${INSTALL_BASE}"       )
set(CMAKE_INSTALL_PREFIX     "${INSTALL_BASE}"       )
set(CMAKE_BUILD_TYPE         "${CONFIG_BUILD_TYPE}"  )
set(CMAKE_VERBOSE_MAKEFILE   OFF                    CACHE BOOL "CMAKE_VERBOSE_MAKEFILE")
set(DEBUG_OUTPUT             OFF                    CACHE BOOL "Enable Disable Debug output")

set(BUILD_RAPIDJSON          OFF                    CACHE BOOL "BUILD_RAPIDJSON")
set(BUILD_FASTCPPCSVPARSER   OFF                    CACHE BOOL "BUILD_FASTCPPCSVPARSER")
set(BUILD_LAPACK             OFF                    CACHE BOOL "BUILD_LAPACK")
set(BUILD_BOOST              OFF                    CACHE BOOL "BUILD_BOOST")
set(BUILD_OPENBLAS           OFF                    CACHE BOOL "BUILD_OPENBLAS")

include(debuglog)

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


# Force Set Dependencies
if(BUILD_OPENBLAS)
    set(BUILD_BOOST ON)
endif()


if(BUILD_RAPIDJSON)

    FetchAndPopulate(
        rapidjson
        /data/git/rapidjson.git
        master
    )
endif()

if(BUILD_LAPACK)

    FetchAndPopulate(
        lapack
        /data/git/lapack.git
        v3.9.0
    )
endif()

if(BUILD_BOOST)
    FetchAndPopulate(
        boost
        /data/git/boost.git
        boost-1.73.0
    )
endif()

if(BUILD_OPENBLAS)
    FetchAndPopulate(
        openblas
        /data/git/OpenBLAS.git
        develop
    )
endif()

if(BUILD_FASTCPPCSVPARSER)
    FetchAndPopulate(
        fastcppcsvparser
        /data/git/fastcppcsvparser.git
        master
    )
endif()

if(BOOGYMAN)
    FetchAndPopulate(
        mp
        /data/git/mp.git
        master
    )
    FetchAndPopulate(
        armadillo
        /data/git/armadillo.git
        9.900.x
    )

    FetchAndPopulate(
        openmpi
        /data/git/openmpi.git
        master
    )
    FetchAndPopulate(
        blaze
        /data/git/blaze.git
        master
    )
    FetchAndPopulate(
        dataframe
        /data/git/dataframe.git
        master
    )


    FetchAndPopulate(
        dlib
        /data/git/dlib.git
        master
    )

    FetchAndPopulate(
        eigen
        /data/git/eigen.git
        3.3.7
    )

    FetchAndPopulate(
        ceres
        /data/git/ceres.git
        master
    )

    FetchAndPopulate(
        ensmallen
        /data/git/ensmallen.git
        master
    )
    FetchAndPopulate(
        gsl
        /data/git/gsl.git
        master
    )
    FetchAndPopulate(
        metatoolkit
        /data/git/metatoolkit.git
        master
    )
    FetchAndPopulate(
        mlpack
        /data/git/mlpack.git
        master
    )
    FetchAndPopulate(
        nlohmannjson
        /data/git/nlohmannjson.git
        master
    )
    FetchAndPopulate(
        nlopt
        /data/git/nlopt.git
        master
    )

    FetchAndPopulate(
        rcpp
        /data/git/rcpp.git
        master
    )
    FetchAndPopulate(
        rinside
        /data/git/rinside.git
        master
    )
    FetchAndPopulate(
        shark
        /data/git/shark.git
        master
    )
    FetchAndPopulate(
        shogun
        /data/git/shogun.git
        master
    )
    FetchAndPopulate(
        universal
        /data/git/universal.git
        master
    )
    FetchAndPopulate(
        vc
        /data/git/vc.git
        master
    )

    FetchAndPopulate(
        vowpalwabbit
        /data/git/vowpalwabbit.git
        master
    )

    FetchAndPopulate(
        xtensor
        /data/git/xtensor.git
        master
    )

    FetchAndPopulate(
        root
        /data/git/root.git
        master
    )
    FetchAndPopulate(
        cpphttplib
        /data/git/cpphttplib.git
        master
    )
    FetchAndPopulate(
        neoml
        /data/git/neoml.git
        master
    )
    FetchAndPopulate(
        xgboost
        /data/git/xgboost.git
        master
    )
    FetchAndPopulate(
        glog
        /data/git/glog.git
        master
    )
    FetchAndPopulate(
        abseilcpp
        /data/git/abseilcpp.git
        master
    )
    FetchAndPopulate(
        simdjson
        /data/git/simdjson.git
        master
    )
    FetchAndPopulate(
        spdlog
        /data/git/spdlog.git
        master
    )
    FetchAndPopulate(
        tensorflow
        /data/git/tensorflow.git
        master
    )
    FetchAndPopulate(
        openpose
        /data/git/openpose.git
        master
    )
    FetchAndPopulate(
        protobuf
        /data/git/protobuf.git
        master
    )
    FetchAndPopulate(
        opencv
        /data/git/opencv.git
        master
    )

    FetchAndPopulate(
        cppalgorithms
        /data/git/cppalgorithms.git
        master
    )

    FetchAndPopulate(
        jemalloc
        /data/git/jemalloc.git
        master
    )

endif()

# Needs to be set in (semi)dependency order
if(BUILD_RAPIDJSON)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/rapidjson)
endif()
if(BUILD_FASTCPPCSVPARSER)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/fastcppcsvparser)
endif()

if(BUILD_BOOST)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/boost)
endif()

if(BUILD_OPENBLAS)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/openblas)
endif()

if(BUILD_LAPACK)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/lapack)
endif()

#include(debuglog)

# End Code


### NOTES / COMMENTS

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
