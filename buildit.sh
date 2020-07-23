#!/usr/bin/env bash

# buildit.sh

# Note: This assumes that all repositories are git repositories accessed via https, or possibly ssh with keys.
#       SVN and direct file access not currently an option... so git er done!

# Boiler code to get the directory of the script were running from
get_script_dir () {
    SOURCE="${BASH_SOURCE[0]}"
    # While $SOURCE is a symlink, resolve it
    while [ -h "$SOURCE" ]; do
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$( readlink "$SOURCE" )"
        # If $SOURCE was a relative symlink (so no "/" as prefix,
        # need to resolve it relative to the symlink base directory
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    BASE_SOURCE=$(basename ${BASH_SOURCE[0]})
    SCRIPT=${DIR}/${BASE_SOURCE}
}

get_script_dir

CONFIG_FILE=${DIR}/buildsys.json
GIT_CLONE_BASE=$(jq -r '.buildsystem.git_clone_base' ${CONFIG_FILE})
if [[ ${GIT_CLONE_BASE} == 'null' ]]; then
  printf "git_clone_base not found...Exiting\n"
  exit
fi

if [[ ! -d ${GIT_CLONE_BASE} ]]; then
  printf "Creating ${GIT_CLONE_BASE}\n"
  mkdir -p ${GIT_CLONE_BASE}
  if [[ ! -d ${GIT_CLONE_BASE} ]]; then
    printf "Unable to create ${GIT_CLONE_BASE}  Exiting. \n"
    exit
  fi  
fi


NUM_PROCS=$(jq -r '.buildsystem.num_procs' ${CONFIG_FILE})
if [[ ${NUM_PROCS} == 'null' ]]; then
  NUM_PROCS=4
fi


CONFIG_CMAKE_RULE_MESSAGES=$(jq -r '.buildsystem.cmake_rule_messages' ${CONFIG_FILE})
if [[ ${CONFIG_CMAKE_RULE_MESSAGES} == 'null' ]] || [[ ${CONFIG_CMAKE_RULE_MESSAGES} -eq 0 ]]; then
  CMAKE_RULE_MESSAGES=''
else
  CMAKE_RULE_MESSAGES="-DCMAKE_RULE_MESSAGES:BOOL=ON"
fi

CONFIG_CMAKE_VERBOSE_MAKEFILE=$(jq -r '.buildsystem.cmake_verbose_makefile' ${CONFIG_FILE})
if [[ ${CONFIG_CMAKE_VERBOSE_MAKEFILE} == 'null' ]] || [[ ${CONFIG_CMAKE_VERBOSE_MAKEFILE} -eq 0 ]]; then
  CMAKE_VERBOSE_MAKEFILE=''
else
  CMAKE_VERBOSE_MAKEFILE="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"
fi

CONFIG_BUILD_TYPE=$(jq -r '.buildsystem.cmake_build_type' ${CONFIG_FILE})

if [[ ${CONFIG_BUILD_TYPE} == "release" ]]; then
  INSTALL_BASE=$(jq -r '.buildsystem.release_install_base' ${CONFIG_FILE})
elif [[ ${CONFIG_BUILD_TYPE} == 'debug' ]]; then
  INSTALL_BASE=$(jq -r '.buildsystem.debug_install_base' ${CONFIG_FILE})
else
  INSTALL_BASE='/usr/local'
fi

printf "SCRIPT:  ${SCRIPT}\n"
printf "DIR:  ${DIR}\n"
printf "CONFIG_FILE:  ${CONFIG_FILE}\n"
printf "GIT_CLONE_BASE:  ${GIT_CLONE_BASE}\n"
printf "CONFIG_BUILD_TYPE:  ${CONFIG_BUILD_TYPE}\n"
printf "INSTALL_BASE:  ${INSTALL_BASE}\n"

printf "===\n"

GLOBAL_CMAKE_ARGS="${CMAKE_RULE_MESSAGES} ${CMAKE_VERBOSE_MAKEFILE} -DCMAKE_FIND_ROOT_PATH=${INSTALL_BASE} -DCMAKE_INSTALL_PREFIX=${INSTALL_BASE} -DCMAKE_BUILD_TYPE=${CONFIG_BUILD_TYPE}  "



# List of packages to build, sorted by rank ( build order )
rank_sorted_package_list=($(jq -r '.|to_entries|sort_by(.value.rank)|from_entries[]|select( (.package != "BuildSys") and (.rank != "") and (.rank > 0) and (.rank != null)  and (.rank|type == "number") )|.package' ${CONFIG_FILE}))

for curr_package in ${rank_sorted_package_list[@]}; do
  printf "\n==  ${curr_package}\n"
  
  # reset starting point to base clone directory for safety
  cd ${GIT_CLONE_BASE}

  GIT_CLONE_DIR=${GIT_CLONE_BASE}/${curr_package}
  SKIP_PACKAGE=$(jq -r ".\"${curr_package}\".skip_package" ${CONFIG_FILE})
  if [[ ${SKIP_PACKAGE} -eq 1 ]]; then
    printf "Skipping package ${curr_package}\n"
    continue
  fi

  CURR_URL=$(jq -r ".\"${curr_package}\".url" ${CONFIG_FILE})
  CURR_RANK=$(jq -r ".\"${curr_package}\".rank" ${CONFIG_FILE})
  CURR_VERSION_ALIAS=$(jq -r ".\"${curr_package}\".version_alias" ${CONFIG_FILE})
  CURR_GIT_COMMIT=$(jq -r ".\"${curr_package}\".git_commit" ${CONFIG_FILE})
  CURR_GIT_BRANCH=$(jq -r ".\"${curr_package}\".git_branch" ${CONFIG_FILE})
  CURR_GIT_TAG=$(jq -r ".\"${curr_package}\".git_tag" ${CONFIG_FILE})
  CURR_GIT_SUBMODULES=$(jq -r ".\"${curr_package}\".git_submodules" ${CONFIG_FILE})
  CURR_CMAKE_ARGS=$(jq -r ".\"${curr_package}\".cmake_args" ${CONFIG_FILE})
  CURR_MAKE_ARGS=$(jq -r ".\"${curr_package}\".make_args" ${CONFIG_FILE})
  CURR_MAKE_TARGETS=$(jq -r ".\"${curr_package}\".make_targets" ${CONFIG_FILE})
  CURR_MAKE_CLEAN=$(jq -r ".\"${curr_package}\".make_clean" ${CONFIG_FILE})
  CURR_CONFIGURE_OPTS=$(jq -r ".\"${curr_package}\".configure_opts" ${CONFIG_FILE})
  CURR_RERUN_CONFIGURE=$(jq -r ".\"${curr_package}\".rerun_configure" ${CONFIG_FILE})
  CURR_UPDATE_GIT=$(jq -r ".\"${curr_package}\".update_git" ${CONFIG_FILE})
  CUSTOM_BUILD_COMMANDS=$(jq -r ".\"${curr_package}\".custom_build_commands" ${CONFIG_FILE})
  CUSTOM_CLEAN_COMMANDS=$(jq -r ".\"${curr_package}\".custom_clean_commands" ${CONFIG_FILE})
  CUSTOM_INSTALL_COMMANDS=$(jq -r ".\"${curr_package}\".custom_install_commands" ${CONFIG_FILE})

  BUILD_GENERATOR=$(jq -r ".\"${curr_package}\".build_generator" ${CONFIG_FILE})
  if [[ ${BUILD_GENERATOR} == 'null' ]]; then
    BUILD_GENERATOR='cmake3'
  fi

  if [[ ${CUSTOM_BUILD_COMMANDS} == 'null' ]]; then
    CUSTOM_BUILD_COMMANDS=''
  fi
  if [[ ${CUSTOM_CLEAN_COMMANDS} == 'null' ]]; then
    CUSTOM_CLEAN_COMMANDS=''
  fi
  if [[ ${CUSTOM_INSTALL_COMMANDS} == 'null' ]]; then
    CUSTOM_INSTALL_COMMANDS=''
  fi

  if [[ ${CURR_UPDATE_GIT} == 'null' ]]; then
    CURR_UPDATE_GIT=0
  fi

  if [[ ${CURR_CMAKE_ARGS} == 'null' ]]; then
    CURR_CMAKE_ARGS=''
  fi

  if [[ ${CURR_MAKE_ARGS} == 'null' ]]; then
    CURR_MAKE_ARGS=''
  fi

  if [[ ${CURR_MAKE_TARGETS} == 'null' ]]; then
    CURR_MAKE_TARGETS=''
  fi

  if [[ ${CURR_CONFIGURE_OPTS} == 'null' ]]; then
    CURR_CONFIGURE_OPTS=''
  fi

  if [[ ${CURR_RERUN_CONFIGURE} == 'null' ]]; then
    CURR_RERUN_CONFIGURE=''
  fi

  USE_SUBMODULES=0
  if [[ ${CURR_GIT_SUBMODULES} != 'null' ]] && [[ ${CURR_GIT_SUBMODULES} -gt 0 ]] ; then
    USE_SUBMODULES=1
  fi
  # if no other options supplied, then set the git reference to be master
  # and initialize the alias to be master as well
  GIT_REF='master'
  GIT_SYMLINK_ALIAS='master'
  # Are ANY of them set?
  if [[ ${CURR_GIT_COMMIT} != 'null' ]] || [[ ${CURR_GIT_BRANCH} != 'null' ]] || [[ ${CURR_GIT_TAG} != 'null' ]]; then
    # Only one can be used... if more than one is set, it will get used on a first come basis..
    if [[ ${CURR_GIT_COMMIT} != 'null' ]]; then
        GIT_REF=${CURR_GIT_COMMIT}
    elif [[ ${CURR_GIT_BRANCH} != 'null' ]]; then
        GIT_REF=${CURR_GIT_BRANCH}
    elif [[ ${CURR_GIT_TAG} != 'null' ]]; then
        GIT_REF=${CURR_GIT_TAG}
    fi

#    printf "commit: ${CURR_GIT_COMMIT}\n"
#    printf "branch: ${CURR_GIT_BRANCH}\n"
#    printf "tag: ${CURR_GIT_TAG}\n"
    printf "ref: ${GIT_REF}\n"
  fi

# Create Clone Directory, If not already there... 
  if [[ ! -d ${GIT_CLONE_DIR} ]]; then
    # printf "${GIT_CLONE_DIR} Not Exist Yet... creating\n"
    mkdir -p ${GIT_CLONE_DIR}
    # Check if it was actually created
    if [[ ! -d ${GIT_CLONE_DIR} ]]; then
        printf "Cant Create ${GIT_CLONE_DIR}  Exiting\n\n"
        exit
    fi
  fi  

  # Only work in the clone directory ... 
  cd ${GIT_CLONE_DIR}

  if [[ ${CURR_UPDATE_GIT} -eq 1 ]];then
    git ls-remote ${GIT_CLONE_DIR}  --quiet 2> /dev/null
    EXIT_STATUS=$?

    if [[ ${EXIT_STATUS} -ne 0 ]]; then
        # Clone the git repository into the clone directory
        printf "Initial Clone of ${CURR_URL}  Into this directory ${GIT_CLONE_DIR}\n"
        git clone --recurse-submodules ${CURR_URL} ${GIT_CLONE_DIR}
        git checkout ${GIT_REF}
        if [[ ${USE_SUBMODULES} -eq 1 ]];then
        git submodule update --init --recursive
        fi
    else
        # Make sure the directory were in is a git repo.
        if [[ $(git status --porcelain &> /dev/null) ]]; then
        printf "Not a git Repo: ${GIT_CLONE_DIR}\n"
        exit
        fi

        git checkout -q --no-progress ${GIT_REF}
        # evaluate whats in git-pull-cron for pulling in all updates, as needed... 
        git fetch --prune

        git pull --ff-only 

        if [[ ${USE_SUBMODULES} -eq 1 ]];then
        git submodule update --init --recursive
        fi
    fi
  fi

  if [[ ${BUILD_GENERATOR} == "cmake3" ]]; then
    # now that the branch is checked out / updated, 
    # we need to build it.. 

    
    if [[ -d  ${GIT_CLONE_DIR}/${curr_package}${CONFIG_BUILD_TYPE}build ]] && [[ ${CURR_MAKE_CLEAN} != 'null' ]] && [[ ${CURR_MAKE_CLEAN} -gt 0 ]]; then
        rm -rf ${GIT_CLONE_DIR}/${curr_package}${CONFIG_BUILD_TYPE}build
    fi
    
    mkdir -p ${GIT_CLONE_DIR}/${curr_package}${CONFIG_BUILD_TYPE}build
    cd ${GIT_CLONE_DIR}/${curr_package}${CONFIG_BUILD_TYPE}build
    #pwd

    printf "cmake3 ${GLOBAL_CMAKE_ARGS} ${CURR_CMAKE_ARGS} ../\n"

    if [[ ${CURR_RERUN_CONFIGURE} -eq 1 ]]; then
      # Generate the Makefiles
      cmake3 ${GLOBAL_CMAKE_ARGS} \
             ${CURR_CMAKE_ARGS} \
             ../
    fi

    # compile the libs and bins
    make -j ${NUM_PROCS} --no-print-directory

    # now that we've built it, we need to install it into our custom root
    make install

  elif [[ ${BUILD_GENERATOR} == "make" ]] || [[ ${BUILD_GENERATOR} == "autoconf" ]];then
    if [[ ${CURR_RERUN_CONFIGURE} -eq 1 ]] && [[ ${BUILD_GENERATOR} == "autoconf" ]]; then
        if [[ ! -f ${GIT_CLONE_DIR}/configure ]]; then
            if [[ -f ${GIT_CLONE_DIR}/autogen.pl ]];then
              ${GIT_CLONE_DIR}/autogen.pl
            elif [[ -f ${GIT_CLONE_DIR}/autogen.sh ]];then
              ${GIT_CLONE_DIR}/autogen.sh
            fi
        fi 
        printf "${GIT_CLONE_DIR}/configure --prefix=${INSTALL_BASE} ${CURR_CONFIGURE_OPTS} \n"
        ${GIT_CLONE_DIR}/configure --prefix=${INSTALL_BASE} ${CURR_CONFIGURE_OPTS} 
    fi

    printf "make_args: ${CURR_MAKE_ARGS}\n"
        # compile the libs and bins
    make ${CURR_MAKE_TARGETS} PREFIX=${INSTALL_BASE} -j ${NUM_PROCS} ${CURR_MAKE_ARGS} --no-print-directory

    # now that we've built it, we need to install it into our custom root
    make install PREFIX=${INSTALL_BASE}
  elif [[ ${BUILD_GENERATOR} == "custom" ]]; then
    printf "build_commands: $(eval ${CUSTOM_BUILD_COMMANDS})\n"
    #printf "build_commands: ${CUSTOM_BUILD_COMMANDS}\n\n"

    #printf "clean_commands: $(eval ${CUSTOM_CLEAN_COMMANDS})\n"
    #printf "clean_commands: ${CUSTOM_CLEAN_COMMANDS}\n\n"
    
    printf "install_commands: $(eval ${CUSTOM_INSTALL_COMMANDS})\n"
    #printf "install_commands: ${CUSTOM_INSTALL_COMMANDS}\n"
    
  fi


  # CWD to the Git Clone Base before continuing
  cd ${GIT_CLONE_BASE}

done

printf "\nTHATs ALL FOLKS!\n"

#################################################################################
#
#
# Interesting jq queries worth keeping... 
# jq '.|keys[]' /data/git/snips/CPP/BuildSys/buildsys.json
# jq 'to_entries|sort_by(.value.rank)|from_entries|keys[]' /data/git/snips/CPP/BuildSys/buildsys.json
# jq '.|to_entries|sort_by(.value.rank)|from_entries[]|{"package":.package, "URL": .url}' buildsys.json
# jq '.|to_entries|sort_by(.value.rank)| . as $in | reduce paths(type != "object" and type != "array") as $path ({}; . + { ($path | map(tostring) | join(".")): $in | getpath($path) })' buildsys.json
