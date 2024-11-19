# Ant {#ant}

[Ant](https://ant.apache.org) is a build system.
It is primarily used to build Java projects.

The setup hook included with the `ant` package sets `buildPhase` and `checkPhase`
by default.

## `ant` thin wrapper {#ant-thin-wrapper}

The `ant` command is thinly wrapped by a Bash function of the same name.
The function executes `ant` with the contents of the `antFlags` variable
(and the associated `antFlagsArray`).

This wrapper is always used in place of `ant` inside of the derivation.
It can be circumvented by calling `command ant`.

## `findExternalAntTasks` {#ant-findExternalAntTasks}

This hook traverses all dependencies of the derivation. If it finds a
`/lib/ant/lib` directory, that directory is appended to `antFlagsArray`
with the `-lib` argument.

## `buildPhase` {#ant-buildPhase}

The Ant `buildPhase` executes `ant` with no arguments by default.

### Parameters {#ant-buildPhase-parameters}

`dontUseAntBuild`
: When set to `true`, disables setting this phase as `buildPhase`.
`antBuildFlags`
: Additional flags passed to Ant in this phase.
`antBuildFlagsArray`
: Additional flags passed to Ant in this phase, as a Bash array.

## `checkPhase` {#ant-checkPhase}

The Ant `checkPhase` executes `ant check` by default.
This default can be changed by setting `antCheckFlags` or `antCheckFlagsArray`.

### Parameters {#ant-checkPhase-parameters}

`dontUseAntCheck`
: When set to `true`, disables setting this phase as `checkPhase`.
`antCheckFlags`
: Additional flags passed to Ant in this phase.
`antCheckFlagsArray`
: Additional flags passed to Ant in this phase, as a Bash array.

