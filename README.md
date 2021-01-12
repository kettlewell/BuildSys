# BuildSys
Build System For Common C++ Data Science / Math Libs

It's not complete, and really only serves my own purpose at this time.

it uses cmake in ways that serve my purpose... and might not be best practices.

# Requirements
* cmake3 ( 3.17 or newer)
* bash

# Basic Usage

Edit make_clean.sh to edit the path of your project, and any settings for verbosity, etc 

Edit BuildSys_config.cmake and turn on any libraries you want to build.
run make_clean.sh to configure and build the libraries, and any apps you use that depend on it.

# Notes
this is really been an exercise in an effort to learn CMake, and super builds so that I can create a personalized development environment that can custom create / build any libraries I want, with whatever custom flags / settings / version that is needed to suit my testing needs.

Use this as a guide, and pick it apart for your own usage as you see fit.

I will likely continue building this up as I try to learn new libraries, and try to re-teach myself C++ ( especailly all these C++11, C++14, C++17 and C++20 additions), especially as it pertains to HPC, and data analytics.









