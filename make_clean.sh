#!/usr/bin/env bash
# set -x

PROJECT='/data/git/BuildSys'
cd ${PROJECT}

# 0 = NONE
# 1 = CLEAN 
# 2 = VERY_CLEAN 
# 3 = SUPER_CLEAN
CLEAN=3

# 0 = NO
# 1 = YES
ANALYSIS=0

# 0 = NO
# 1 = YES
INSTALL=1

# 0 = NO
# 1 = YES
VERBOSITY=1

# Jobs
JOBS="-j20"

CMAKE3=$(type -P cmake3)
RM=$(type -P rm)


# Super Clean
if [ ${CLEAN} -ge 3 ]; then
    printf "rm -r /data/opt/*\n"
    ${RM} -r /data/opt/*
fi

# Very Clean
if [ ${CLEAN} -ge 2 ]; then
    printf "rm -rf ${PROJECT}/build/\n"
    ${RM} -rf ${PROJECT}/build/
fi

# Clean
if [ ${CLEAN} -ge 1 ]; then
    printf "rm -r ${PROJECT}/build/CMake*\n"
    ${RM} -r ${PROJECT}/build/CMake*
fi

if [ ${VERBOSITY} -ge 1 ]; then
    printf "VERBOSE ON\n"
    VERBOSE="-v"
fi

# TODO: 
#      create separate clean / build scripts 
#      ... or a better single script with options
#


#rm -rf build ; cmake3 -S . -B build && cmake3 --build build -j20
#cmake3 -S . -B build -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON && cmake3 --build build -j20


# Build Definitions File, Relative the the CMAKE_SOURCE_DIR
BUILDSYS_CONFIG="-DBUILDSYS_CONFIG:PATH=BuildSys_config.cmake"
CMAKE_CONFIG_ARGS="${VERBOSE}"
CMAKE_BUILD_ARGS="${VERBOSE} ${JOBS}"
#GMAKE_BUILD_ARGS="-- --no-print-directory"
GMAKE_BUILD_ARGS=""


time  { 
    ${CMAKE3}  ${CMAKE_CONFIG_ARGS} -S ${PROJECT} -B build  ${BUILDSYS_CONFIG} \
    &&  ${CMAKE3}  --build ${PROJECT}/build ${CMAKE_BUILD_ARGS} ${GMAKE_BUILD_ARGS}
}

