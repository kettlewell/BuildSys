#!/usr/bin/env bash

# TODO: 
#      create separate clean / build scripts 
#      ... or a better single script with options
#

cd /data/git/BuildSys/CMakeProjectTest

#rm -rf build ; cmake3 -S . -B build && cmake3 --build build -j20
#cmake3 -S . -B build -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON && cmake3 --build build -j20


# Build Definitions
DEBUG_OUTPUT="-DDEBUG_OUTPUT:BOOL=ON"
INSTALL_BASE="-DINSTALL_BASE:PATH=/data/opt"
CMAKE_VERBOSE_MAKEFILE="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"
CONFIG_BUILD_TYPE="-DCONFIG_BUILD_TYPE:STRING=RELEASE"
BUILD_RAPIDJSON="-DBUILD_RAPIDJSON:BOOL=ON"
BUILD_FASTCPPCSVPARSER="-DBUILD_FASTCPPCSVPARSER:BOOL=ON"
BUILD_LAPACK="-DBUILD_LAPACK:BOOL=ON"
BUILD_BOOST="-DBUILD_BOOST:BOOL=ON"
BUILD_OPENBLAS="-DBUILD_OPENBLAS:BOOL=ON"

#="-D:BOOL=ON"



DEFINITIONS=$( cat << EOM
    ${DEBUG_OUTPUT}
    ${INSTALL_BASE}
    ${CMAKE_VERBOSE_MAKEFILE}
    ${CONFIG_BUILD_TYPE}
    ${BUILD_RAPIDJSON}
    ${BUILD_FASTCPPCSVPARSER}
    ${BUILD_LAPACK}
    ${BUILD_BOOST}
    ${BUILD_OPENBLAS}
EOM
)

#cmake3 options
JOBS="-j20"
VERBOSE="-v"

CMAKE_CONFIG_ARGS="${VERBOSE}"
CMAKE_BUILD_ARGS="${VERBOSE} ${JOBS}"

# Super Clean
#rm -r /data/opt/*

# Very Clean
rm -rf build/              &&

# Clean
rm -rf build/CMake*        &&
cmake3  ${CMAKE_CONFIG_ARGS} -S . -B build  ${DEFINITIONS}   && 
cmake3  --build build ${CMAKE_BUILD_ARGS}


