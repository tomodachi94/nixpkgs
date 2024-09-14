# paxctl {#paxctl-hook}

This setup hook exposes a function, `paxmark`, which uses `paxctl` to manipulate the [PaX](https://en.wikipedia.org/wiki/Executable-space_protection#PaX) flags in a standard way:
* Convert the headers from the old-style `PT_GNU_STACK` program header to the newer `PT_PAX_FLAGS` header.
* Reset all previous flags, then set the `NOEMUTRAMP` and `NORANDEXEC` flags.
