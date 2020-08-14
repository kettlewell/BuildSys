# Top Level CMAKE File
cmake_minimum_required(VERSION 3.14)

project(buildsys)

# TODO: 
#       * remove policy deprecation warnings  ( which ones? I don't see them now )
#       * enhance messages... still unclear on a few items. ( Done ? )
#       * move Fetch and add_subdirectory projects into user configurable
#             files, same as the BuildSys_config.cmake overridable file.



# Add the project cmake path
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

set(BUILDSYS_CONFIG "BuildSys_config.cmake" CACHE PATH "BuildSys Configuration File - relative to CMAKE_SOURCE_DIR")
set(BUILDSYS_CONFIG ${CMAKE_SOURCE_DIR}/${BUILDSYS_CONFIG})

if(EXISTS ${BUILDSYS_CONFIG})
    include(${BUILDSYS_CONFIG})
else()
    message(FATAL_ERROR "CONFIG FILE NOT FOUND: ${BUILDSYS_CONFIG}")
endif()



# TODO: cmakepp is a cmake library of "things"
# include(installcmakepp)

# TODO: Cleanup this variable mess ... ( Done ?)

set(CMAKE_FIND_ROOT_PATH     "${INSTALL_BASE}"       )
set(CMAKE_INSTALL_PREFIX     "${INSTALL_BASE}"       )
set(CMAKE_BUILD_TYPE         "${CONFIG_BUILD_TYPE}"  )


include(debuglog)

# TODO: Remove global compiler options ... not sure where I found this from, 
#       But I don't think this is what I want.

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


# Create Pseudo Dependency Tree
# This isn't strictly necessary, but a convenience to me
# so that it will auto build any dependent libs for me

if(BUILD_SHARK)
    set(BUILD_OPENBLAS  ON)
endif()

if(BUILD_SHOGUN)
    set(BUILD_EIGEN     ON)
endif()

if(BUILD_ENSMALLEN)
    set(BUILD_ARMADILLO ON)
endif()

if(BUILD_ARMADILLO)
    set(BUILD_LAPACK   ON)
endif()

if(BUILD_CERES)
    set(BUILD_EIGEN    ON)
endif()

if(BUILD_BLAZE)
    set(BUILD_LAPACK   ON)
endif()

if(BUILD_EIGEN)
    set(BUILD_LAPACK   ON)
endif()

if(BUILD_LAPACK)
    set(BUILD_OPENBLAS ON)
endif()

if(BUILD_OPENBLAS)
    set(BUILD_BOOST    ON)
endif()

if(BUILD_BOOST)
    set(BUILD_OPENMPI  ON)
endif()

###

include(FetchAndPopulate)

# TODO: Move Fetching & External Projects to overridable file.
# # Fetch the files and stage them Build External Projects

# Needs to be set in (semi)dependency order
# Not a fan of multiple dependency trees, but... it is what it is.

# No Dependencies
if(BUILD_RAPIDJSON)    
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/rapidjson) 
endif()

if(BUILD_FASTCPPCSVPARSER)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/fastcppcsvparser)
endif()

if(BUILD_NLOHMANNJSON)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/nlohmannjson)
endif()

#####################

if(BUILD_JEMALLOC)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/jemalloc) 
endif()


if(BUILD_OPENMPI)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/openmpi)
endif()

if(BUILD_BOOST)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/boost)
endif()

if(BUILD_OPENBLAS)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/openblas)
endif()

if(BUILD_SHARK)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/shark)
endif()


if(BUILD_LAPACK)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/lapack)
endif()


if(BUILD_ARMADILLO)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/armadillo)
endif()

if(BUILD_DATAFRAME)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/dataframe)
endif()

if(BUILD_EIGEN)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/eigen)
endif()

if(BUILD_CERES)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/ceres)
endif()

if(BUILD_BLAZE)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/blaze)
endif()

if(BUILD_PROTOBUF)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/protobuf)
endif()

if(BUILD_SHOGUN)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/shogun)
endif()

if(BUILD_OPENCV)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/opencv)
endif()

if(BUILD_ENSMALLEN)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/ensmallen)
endif()

if(BUILD_GSL)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/gsl)
endif()

if(BUILD_MLPACK)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/mlpack)
endif()

if(BUILD_SPDLOG)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/spdlog)
endif()

if(BUILD_GLOG)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/glog)
endif()

if(BUILD_RCPP)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/rcpp)
endif()

if(BUILD_RINSIDE)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/rinside)
endif()

if(BUILD_SIMDJSON)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/simdjson)
endif()

if(BUILD_CPPALGORITHMS)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/cppalgorithms)
endif()

if(BUILD_ABSEILCPP)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/abseilcpp)
endif()

if(BUILD_OPENPOSE)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/openpose)
endif()

if(BUILD_TENSORFLOW)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/tensorflow)
endif()

if(BUILD_CPPHTTPLIB)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/cpphttplib)
endif()

if(BUILD_NEOML)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/neoml)
endif()

if(BUILD_MP)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/mp)
endif()

if(BUILD_DLIB)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/dlib)
endif()

if(BUILD_METATOOLKIT)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/metatoolkit)
endif()

if(BUILD_NLOPT)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/nlopt)
endif()

if(BUILD_UNIVERSAL)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/universal)
endif()

if(BUILD_VC)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/vc)
endif()

if(BUILD_VOWPALWABBIT)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/vowpalwabbit)
endif()

if(BUILD_XTENSOR)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/xtensor)
endif()

if(BUILD_ROOT)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/ROOT)
endif()

if(BUILD_BAT)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/bat)
endif()

if(BUILD_XGBOOST)
    add_subdirectory(${CMAKE_SOURCE_DIR}/external/xgboost)
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
