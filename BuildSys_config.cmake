
set(CONFIG_BUILD_TYPE                 "Release"     CACHE STRING "CONFIG_BUILD_TYPE"    )
set(INSTALL_BASE                      "/data/opt"   CACHE PATH   "INSTALL BASE"         )

set(CMAKE_VERBOSE_MAKEFILE            ON           CACHE BOOL   "CMAKE_VERBOSE_MAKEFILE")
set(DEBUG_OUTPUT                      ON           CACHE BOOL   "Enable Disable Debug output")

# BUILD OFF/ON
set(BUILD_RAPIDJSON                   OFF           CACHE BOOL   "BUILD_RAPIDJSON")
set(BUILD_FASTCPPCSVPARSER            OFF           CACHE BOOL   "BUILD_FASTCPPCSVPARSER")
set(BUILD_LAPACK                      OFF           CACHE BOOL   "BUILD_LAPACK")
set(BUILD_BOOST                       OFF           CACHE BOOL   "BUILD_BOOST")
set(BUILD_OPENBLAS                    OFF           CACHE BOOL   "BUILD_OPENBLAS")
set(BUILD_ARMADILLO                   OFF           CACHE BOOL   "BUILD_ARMADILLO")
set(BUILD_DATAFRAME                   OFF           CACHE BOOL   "BUILD_DATAFRAME")
set(BUILD_EIGEN                       OFF           CACHE BOOL   "BUILD_EIGEN")
set(BUILD_CERES                       OFF           CACHE BOOL   "BUILD_CERES")
set(BUILD_OPENMPI                     OFF           CACHE BOOL   "BUILD_OPENMPI")
set(BUILD_BLAZE                       OFF           CACHE BOOL   "BUILD_BLAZE")
set(BUILD_JEMALLOC                    OFF           CACHE BOOL   "BUILD_JEMALLOC")



# TODO

set(BUILD_NLOHMANNJSON                OFF           CACHE BOOL   "BUILD_NLOHMANNJSON")

# make build generator
set(BUILD_PROTOBUF                    OFF           CACHE BOOL   "BUILD_PROTOBUF")

# requires boost, but didn't use my version of boost?
set(BUILD_SHARK                       OFF           CACHE BOOL   "BUILD_SHARK")

# requires eigen3
set(BUILD_SHOGUN                      OFF           CACHE BOOL   "BUILD_SHOGUN")

set(BUILD_OPENCV                      OFF           CACHE BOOL   "BUILD_OPENCV")

# requires armadillo
set(BUILD_ENSMALLEN                   OFF           CACHE BOOL   "BUILD_ENSMALLEN")

# autoconf
set(BUILD_GSL                         OFF           CACHE BOOL   "BUILD_GSL")

# requires boost
set(BUILD_MLPACK                      OFF           CACHE BOOL   "BUILD_MLPACK")

set(BUILD_SPDLOG                      OFF           CACHE BOOL   "BUILD_SPDLOG")
set(BUILD_GLOG                        OFF           CACHE BOOL   "BUILD_GLOG")

# rtools build tool
set(BUILD_RCPP                        OFF           CACHE BOOL   "BUILD_RCPP")
set(BUILD_RINSIDE                     OFF           CACHE BOOL   "BUILD_RINSIDE")

set(BUILD_SIMDJSON                    OFF           CACHE BOOL   "BUILD_SIMDJSON")
set(BUILD_CPPALGORITHMS               OFF           CACHE BOOL   "BUILD_CPPALGORITHMS")
set(BUILD_ABSEILCPP                   OFF           CACHE BOOL   "BUILD_ABSEILCPP")
set(BUILD_OPENPOSE                    OFF           CACHE BOOL   "BUILD_OPENPOSE")
set(BUILD_TENSORFLOW                  OFF           CACHE BOOL   "BUILD_TENSORFLOW")
set(BUILD_CPPHTTPLIB                  OFF           CACHE BOOL   "BUILD_CPPHTTPLIB")

# build issues - ninja cmake instructions
set(BUILD_NEOML                       OFF           CACHE BOOL   "BUILD_NEOML")

# Build Issue
set(BUILD_MP                          OFF           CACHE BOOL   "BUILD_MP")

# Requires X11 / cuda ?
set(BUILD_DLIB                        OFF           CACHE BOOL   "BUILD_DLIB")

#Build Issue
set(BUILD_METATOOLKIT                 OFF           CACHE BOOL   "BUILD_METATOOLKIT")

set(BUILD_NLOPT                       OFF           CACHE BOOL   "BUILD_NLOPT")

# Build Issue
set(BUILD_UNIVERSAL                   OFF           CACHE BOOL   "BUILD_UNIVERSAL")

# Builds
set(BUILD_VC                          OFF           CACHE BOOL   "BUILD_VC")

# requires boost
set(BUILD_VOWPALWABBIT                OFF           CACHE BOOL   "BUILD_VOWPALWABBIT")

# build issues
set(BUILD_XTENSOR                     OFF           CACHE BOOL   "BUILD_XTENSOR")

# requires x11
set(BUILD_ROOT                        OFF           CACHE BOOL   "BUILD_ROOT")
set(BUILD_BAT                         OFF           CACHE BOOL   "BUILD_BAT")

set(BUILD_XGBOOST                     OFF           CACHE BOOL   "BUILD_XGBOOST")




## LIBRARY DEFINITIONS
# RapidJson

# Fast CPP CSV Parser

# Lapack
set(BS_LAPACK_USE_OPTIMIZED_BLAS      ON            CACHE BOOL   "LAPACK - USE_OPTIMIZED_BLAS")
set(BS_LAPACK_BUILD_SHARED_LIBS       ON            CACHE BOOL   "LAPACK - BUILD_SHARED_LIBS")

# Boost

# OpenBlas

# Armadillo

# Dataframe

# Eigen

# Ceres Solver
set(BS_CERES_GFLAGS                   OFF           CACHE BOOL   "CERES - Enable/Disable GFLAGS")
set(BS_CERES_MINIGLOG                 ON            CACHE BOOL   "CERES - Enable/Disable MINIGLOG")
set(BS_CERES_CMAKE_CXX_STANDARD       "14"          CACHE STRING "CERES - Set CXX Standard") 
set(BS_CERES_CERES_THREADING_MODEL    "OPENMP"      CACHE STRING "CERES - Set Threading Model")
set(BS_CERES_BUILD_TESTING            OFF           CACHE BOOL   "CERES - Enable/Disable Testing") 
set(BS_CERES_BUILD_EXAMPLES           OFF           CACHE BOOL   "CERES - Enable/Disable Examples") 
set(BS_CERES_BUILD_BENCHMARKS         OFF           CACHE BOOL   "CERES - Enable/Disable Benchmarks")  
set(BS_CERES_LIB_SUFFIX               "64"          CACHE STRING "CERES - Set Lib Suffix") 
set(BS_CERES_BUILD_SHARED_LIBS        ON            CACHE BOOL   "CERES - Enable/Disable Shared Libs")  
set(BS_CERES_SUITESPARSE              OFF           CACHE BOOL   "CERES - Enable/Disable SuiteSparse")
set(BS_CERES_CXSPARSE                 OFF           CACHE BOOL   "CERES - Enable/Disable CX Sparse")

# OpenMPI
