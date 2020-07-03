# BuildSys
Build System For Common C++ Data Science / Math Libs

This is just a config file driven way to quickly create set of libraries that I can reference in one place that has non-standard flags and options for developement purposes.

It's not complete, and really only serves my own purpose at this time.

It basically is just a json file that lists out what package you're wanting to build, where it can find it, and what options you want to give it to build with.

It's not feature complete, and pretty much undocumented ... I'm sure I'll a few features as I fine tune it, and might even document bits and pieces as I go along to remind myself.

If you happen to stuble across this, and have a question, or ( gasp ) a feature request, let me know.

# Requirements
* jq
* bash

jq is required for parsing the json config file in a bash shell.

# Development Notes
The idea is to take a config file of thirdparty libraries, and build various versions of them, with different configurations

Let's start with simple use-cases first

Read in a config file with github URL's to projects... 

Most projects should be in git now ... those that aren't, likely have a tarball for download, and they can be handled as one-off cases... 

Allow building of "latest" for now ... with commit / tag / branch version later... 

debug and release versions only... 

symlink to the active version ( latest in first iteration )

Use each library's build system to build, and develop the correct inputs/outputs for paths

determine what the build order is, and make it extensible to modify order of builds for dependencies.

TODO: 
= generalize/consolidate buildsys.json ... 
= create pre/post commands ... 
= create named version directories to allow multiple builds ... 
= accept config file argument from script ... 
= implement remaining options... 
= cleanup structure... push to github ... 
= implement "uninstall" option to delete files from install base or wipe out and start over.
= pin libs to versions


Buildsys.json key/value options:
* package
* rank
* debug_install_base
* release_install_base
* git_clone_base
* num_procs
* cmake_rule_messages
* cmake_verbose_makefile
* cmake_build_type

* url
* source_type
* dl_source
* version_alias
* git_commit
* git_branch
* git_tag
* git_submodules
* update_git
* build_generator
* custom_build_commands
* custom_clean_commands
* custom_install_commands
* needs
* notes
* rerun_configure
* make_clean
* make_args
* make_targets
* cmake_args
* configure_opts
* skip_package
