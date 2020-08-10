
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
