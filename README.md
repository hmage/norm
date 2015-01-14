NORM = NOt Root (package) Manager
====

You don't need root to install anything.

Example:
```
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

For examples, see existing packages.

Since the variability of systems the code will be built on is big, please make sure build process doesn't depend on anything but system's gcc/binutils and system's glibc. Every other dependency should be brought with you.
