

project( fastcppcsvparser )
#list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(enter)
include(ExternalProject)

### fastcppcsvparser
set(EP_fastcppcsvparser "fastcppcsvparser_git")
ExternalProject_Add(${EP_fastcppcsvparser}
    PREFIX ${EP_fastcppcsvparser}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    #SOURCE_DIR ${${EP_fastcppcsvparser}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/fastcppcsvparser.git
    GIT_TAG  master
    BUILD_IN_SOURCE 1
    PATCH_COMMAND mkdir -p <INSTALL_DIR>/include
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND cp <SOURCE_DIR>/csv.h <INSTALL_DIR>/include/
    LOG_DOWNLOAD ON
    LOG_UPDATE ON
    LOG_CONFIGURE ON
    LOG_BUILD ON
    LOG_INSTALL ON
    WORKING_DIRECTORY <SOURCE_DIR>
)

#include(debuglog)
include(exit)

# TODO: create uninstall lists for non-cmake systems.

#$ pwd
#/data/git/snips/CMakeProjectTest/build/_deps/fastcppcsvparser_git-src

#installed_files=$( 
#    make      \
#    -s \
#    PREFIX=/data/opt \
#    -n install \
#    -o all   |  \
#    grep -Eo  "\"/data/opt/.*\"" | \
#    awk -F '"' '{print $2}' | \
#    sort -n | \
#    uniq
#)

#for x in ${installed_files}; do 
#  echo -n $x; 
#  if [[ -f ${x} ]]; then 
#    echo " file found"; 
#  elif [[ -d ${x} ]]; then 
#    echo " Directory Found"; 
#  else 
#    echo " other found"; 
#  fi ; 
#done

