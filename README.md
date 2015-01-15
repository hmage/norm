NORM = NOt Root (package) Manager
====

You don't need root to install anything.

Example:
```bash
norm install gcc
```

This installs gcc to $HOME/norm/ directory by downloading source and compiling gcc and it's dependencies.

====

The main goal of this package manager is to provide easy way to install software when you don't have root privileges and write access anywhere but your home directory. You'll be surprised how much software you can install this way.

====

Adding new package:

 * Create a file in `packages` directory.
 * Add `fetch_source` line first.
 * Add `depends_on` lines if neccessary.
 * Add `do_unpack_compile` line.

Example:
```bash
#!/usr/bin/env bash
fetch_source http://ftpmirror.gnu.org/tar/tar-1.28.tar.gz cd30a13bbfefb54b17e039be7c43d2592dd3d5d0

depends_on libacl libattr

do_unpack_compile tar-1.28 tar-1.28.tar.gz
```

For more examples, see existing packages.

Since the variability of systems the code will be built on is big, please make sure build process doesn't depend on anything but system's gcc/binutils and system's glibc. Every other dependency should be brought with you.
