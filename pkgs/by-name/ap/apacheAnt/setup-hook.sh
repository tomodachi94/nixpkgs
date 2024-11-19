# shellcheck shell=bash

# Searches for JARs in lib/ant/lib of all dependencies,
# and adds them to antFlagsArray if they exist.
# This is useful for packages that need a task not
# provided in Ant, e.g. those in ant-contrib.
function findExternalAntTasks() {
  if [ -d "$1/lib/ant/lib" ]; then
    # antFlagsArray+="$(find "$1/lib/ant/lib" -type f -name '*.jar' -printf '-lib %p')"
    antFlagsArray+=("-lib" "$1/lib/ant/lib")
  fi
}

addEnvHooks "$targetOffset" findExternalAntTasks

# Thinly wraps the ant executable, minimizing
# copy/paste in phases.
# Variables:
#   antFlags
#     A string of flags to be passed to Ant in all phases.
#   antFlagsArray
#     An array of flags to be passed to Ant in all phases.
function ant() {
  local flagsArray=()
  concatTo flagsArray antFlags antFlagsArray
  command ant "${flagsArray[@]}" "$@"
}

# Build the project using Ant, using the project's
# [default target](https://ant.apache.org/manual/using.html#projects)
# Variables:
#   antBuildFlags
#     A string of flags to be passed to Ant.
#   antBuildFlagsArray
#     A Bash array of flags to be passed to Ant.
function antBuildPhase() {
  runHook preBuild

  local flagsArray=()
  concatTo flagsArray antBuildFlags antBuildFlagsArray
  ant "${flagsArray[@]}"

  runHook postBuild
}

# Check the project using Ant
# by default.
# Variables:
#   antCheckFlags
#     A string of flags to be passed to Ant.
#   antCheckFlagsArray
#     A Bash array of flags to be passed to Ant.
function antCheckPhase() {
  runHook preCheck

  local flagsArray=()
  concatTo flagsArray antCheckFlags antCheckFlagsArray

  # Set a reasonable default
  if [ ${#flagsArray[@]} -eq 0 ]; then
    flagsArray=("check")
  fi

  ant "${flagsArray[@]}"

  runHook postCheck
}

if [ -z "${dontUseAntBuild-}" ] && [ -z "${buildPhase-}" ]; then
    buildPhase=antBuildPhase
fi

if [ -z "${dontUseAntCheck-}" ] && [ -z "${checkPhase-}" ]; then
    checkPhase=antCheckPhase
fi

