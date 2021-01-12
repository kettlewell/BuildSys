cmake_minimum_required(VERSION 3.17)

project(hello C CXX)


#set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

#set (Boost_USER_STATIC_LIBS ON)
#find_package (Boost REQUIRED COMPONENTS date_time filesystem system thread)
find_package (Boost REQUIRED COMPONENTS date_time filesystem system)

find_package(LAPACK REQUIRED)
find_package(OpenBLAS REQUIRED)

find_package(RapidJSON REQUIRED)

# Create a sources variable with a link to all cpp files to compile
set(SOURCES
    hello.cc
)

add_executable(${PROJECT_NAME} ${SOURCES})

include_directories(${Boost_INCLUDE_DIRS} ${RapidJSON_INCLUDE_DIRS})

target_link_libraries(${PROJECT_NAME}
    ${Boost_LIBRARIES}
    ${OpenBLAS_LIBRARIES}
    ${LAPACK_LIBRARIES}
)
# Additional / Potential target_link_libraries()
    #  ${Boost_THREAD_LIBRARY}
    #  Threads::Threads
    #  ${CMAKE_THREAD_LIBS_INIT}
    #  ${LAPACK_LIBRARIES}
#target_compile_options(${PROJECT_NAME}
#    INTERFACE $<BUILD_INTERFACE:${LAPACK_LINKER_FLAGS}>
#)

install(TARGETS ${PROJECT_NAME} DESTINATION bin)

#include(debuglog)
