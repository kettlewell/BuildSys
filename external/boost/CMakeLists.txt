# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# From: https://github.com/apache/geode-native/tree/develop/dependencies/boost



#project( boost VERSION 1.73.0 LANGUAGES NONE )
project( boost LANGUAGES NONE )

#list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(enter)

set(BUILD_BITS 64 CACHE STRING "Build for 64 (default) or 32 bit.")


  #--with-system
  #--with-log
  #--with-serialization
  #--with-thread
  #--with-test
  #--with-timer
  #--with-regex
  #--with-random
  
set(_B2_FLAGS -d3 --prefix=<INSTALL_DIR>
  --without-python
  --without-graph_parallel
  --without-wave
  --layout=system
  address-model=${BUILD_BITS}
  link=shared
  threading=multi
)

include(ProcessorCount)
ProcessorCount(_NPROCS)
if (${_NPROCS})
  set ( _B2_FLAGS ${_B2_FLAGS} -j${_NPROCS} )
endif()

  set ( _BOOTSTRAP_COMMAND ./bootstrap.sh )
  set ( _B2_COMMAND ./b2 )
  set ( _B2_FLAGS ${_B2_FLAGS} "cxxflags=${CMAKE_CXX_FLAGS} ${CMAKE_CXX11_STANDARD_COMPILE_OPTION} ${CMAKE_CXX_COMPILE_OPTIONS_PIC}" )

#string(REPLACE "." "_" _VERSION_UNDERSCORE ${PROJECT_VERSION})

set(EP_boost "boost_git")
set(EXTERN ${EP_boost} )

include(ExternalProject)

# Boost
ExternalProject_Add(${EP_boost}
    PREFIX boost_git
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #SOURCE_DIR ${boost_git_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/boost.git
    GIT_TAG  boost-1.73.0
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${_BOOTSTRAP_COMMAND}
    BUILD_COMMAND ${_B2_COMMAND} ${_B2_FLAGS}
    INSTALL_COMMAND ${_B2_COMMAND}  ${_B2_FLAGS} install
    LOG_DOWNLOAD ON
    LOG_UPDATE ON
    LOG_CONFIGURE ON
    LOG_BUILD ON
    LOG_INSTALL ON
    #DEPENDS openmpi_git
)

ExternalProject_Get_Property( ${EP_boost} BUILD_COMMAND INSTALL_COMMAND INSTALL_DIR PREFIX SOURCE_DIR)


function(ADD_BOOST_LIBRARY)
  set(options)
  set(oneValueArgs)
  set(multiValueArgs LIBRARIES DEPENDENCIES)
  cmake_parse_arguments(PARSE_ARGV 1 args "${options}" "${oneValueArgs}" "${multiValueArgs}")

  set(args_NAME ${ARGV0})

  if (NOT DEFINED args_LIBRARIES)
    set(args_LIBRARIES ${args_NAME})
  endif()

  set(linkLibraries)
  foreach(library ${args_LIBRARIES})
    list(APPEND linkLibraries "${INSTALL_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}boost_${args_NAME}${CMAKE_STATIC_LIBRARY_SUFFIX}")
  endforeach()

  add_library(boost_${args_NAME} INTERFACE)
  target_link_libraries(boost_${args_NAME} INTERFACE
    ${linkLibraries}
    ${args_DEPENDENCIES}
  )
  add_library(Boost::${args_NAME} ALIAS boost_${args_NAME})


endfunction()


add_library(${PROJECT_NAME} INTERFACE)
target_include_directories(${PROJECT_NAME} SYSTEM INTERFACE
  $<BUILD_INTERFACE:${INSTALL_DIR}/include>
)
target_compile_definitions(${PROJECT_NAME} INTERFACE
  BOOST_ALL_NO_LIB
)
target_link_libraries(${PROJECT_NAME} INTERFACE
)
add_library(Boost::boost ALIAS boost)
add_dependencies(${PROJECT_NAME} ${EXTERN})

find_package(Threads REQUIRED)

add_boost_library(system DEPENDENCIES Boost::boost)
add_boost_library(atomic DEPENDENCIES Boost::boost)
add_boost_library(thread DEPENDENCIES Threads::Threads Boost::atomic Boost::boost)
add_boost_library(filesystem DEPENDENCIES Boost::system Boost::boost)
add_boost_library(log DEPENDENCIES Boost::thread Boost::filesystem Boost::boost)
add_boost_library(log_setup DEPENDENCIES Boost::log)
add_boost_library(chrono DEPENDENCIES Boost::chrono)
add_boost_library(stacktrace LIBRARIES "" DEPENDENCIES Boost::boost)
add_boost_library(asio LIBRARIES "" DEPENDENCIES Boost::boost)
add_boost_library(process LIBRARIES "" DEPENDENCIES Boost::system)

target_compile_definitions(boost_stacktrace INTERFACE
  BOOST_STACKTRACE_GNU_SOURCE_NOT_REQUIRED
)

target_compile_definitions(boost_asio INTERFACE
    BOOST_ASIO_HAS_MOVE
)


#  include(debuglog)
include(exit)
