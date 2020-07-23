#!/usr/bin/env bash

cd /data/git/snips/CMakeProjectTest

#rm -rf build ; cmake3 -S . -B build && cmake3 --build build -j20
#cmake3 -S . -B build -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON && cmake3 --build build -j20

# Super Clean
rm -r /data/opt/*

# Very Clean
rm -rf build/              &&

# Clean
rm -rf build/CMake*        &&
cmake3  -S . -B build       && 
cmake3 --build build -j20 


