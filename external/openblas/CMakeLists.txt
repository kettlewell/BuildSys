

project( openblas )
include(enter)

include(ProcessorCount)
set(NPROCS 4)
ProcessorCount(_NPROCS)
if (${_NPROCS})
  set ( NPROCS ${_NPROCS} )
endif()

#list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
#include(debuglog)

include(ExternalProject)

### openblas
set(EP_openblas "openblas_git")
ExternalProject_Add(${EP_openblas}
    PREFIX ${EP_openblas}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    # SOURCE_DIR ${${EP_openblas}_SOURCE_DIR}  # Provided by FetchContent
    GIT_REPOSITORY /data/git/openblas.git
    GIT_TAG  develop
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${CMAKE_MAKE_PROGRAM}  USE_OPENMP=1 NO_LAPACK=1 NO_AFFINITY=0 MAKE_NB_JOBS=20 CPP_THREAD_SAFETY_TEST=0 -j${NPROCS} libs shared
    INSTALL_COMMAND ${CMAKE_MAKE_PROGRAM} install PREFIX=<INSTALL_DIR>
    LOG_DOWNLOAD ON
    LOG_UPDATE ON
    LOG_CONFIGURE ON
    LOG_BUILD ON
    LOG_INSTALL ON
    WORKING_DIRECTORY <SOURCE_DIR>
    DEPENDS openmpi_git
)

#include(debuglog)
include(exit)
# TODO: create uninstall lists for non-cmake systems.

#$ pwd
#/data/git/snips/CMakeProjectTest/build/_deps/openblas_git-src

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


# Sample Add Step
#ExternalProject_Add_Step(
#    openblas lapacke_install
#    COMMAND ${CMAKE_COMMAND} -E copy "${CBLAS_SOURCES_DIR}/src/openblas/lapack-netlib/LAPACKE/include/lapacke_mangling_with_flags.h" "${CBLAS_INSTALL_DIR}/include/lapacke_mangling.h"
#    COMMAND ${CMAKE_COMMAND} -E copy "${CBLAS_SOURCES_DIR}/src/openblas/lapack-netlib/LAPACKE/include/lapacke.h" "${CBLAS_INSTALL_DIR}/include/lapacke.h"
#    COMMAND ${CMAKE_COMMAND} -E copy "${CBLAS_SOURCES_DIR}/src/openblas/lapack-netlib/LAPACKE/include/lapacke_config.h" "${CBLAS_INSTALL_DIR}/include/lapacke_config.h"
#    COMMAND ${CMAKE_COMMAND} -E copy "${CBLAS_SOURCES_DIR}/src/openblas/lapack-netlib/LAPACKE/include/lapacke_utils.h" "${CBLAS_INSTALL_DIR}/include/lapacke_utils.h"
#    DEPENDEES install
#)	    )
