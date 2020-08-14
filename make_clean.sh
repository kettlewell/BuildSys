#!/usr/bin/env bash

# TODO: 
#      create separate clean / build scripts 
#      ... or a better single script with options
#

cd /data/git/BuildSys/

#rm -rf build ; cmake3 -S . -B build && cmake3 --build build -j20
#cmake3 -S . -B build -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON && cmake3 --build build -j20


# Build Definitions File, Relative the the CMAKE_SOURCE_DIR
BUILDSYS_CONFIG="-DBUILDSYS_CONFIG:PATH=BuildSys_config.cmake"

#cmake3 options
JOBS="-j20"
VERBOSE="-v"

CMAKE_CONFIG_ARGS="${VERBOSE}"
CMAKE_BUILD_ARGS="${VERBOSE} ${JOBS}"
#GMAKE_BUILD_ARGS="-- --no-print-directory"
GMAKE_BUILD_ARGS=""

# Remove
rm -rf /data/opt/*           

# Very Clean
# rm -rf build/              

# Clean
rm -rf build/CMake*        &&
cmake3  ${CMAKE_CONFIG_ARGS} -S . -B build  ${BUILDSYS_CONFIG}   && 
cmake3  --build build ${CMAKE_BUILD_ARGS} ${GMAKE_BUILD_ARGS}


