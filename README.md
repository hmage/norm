#NORM = NOt Root (package) Manager

Easy way to install software when you don't have root and can only write to your home directory. 

Example:
```bash
norm install gcc
```

This installs gcc to `$HOME/norm/bin/gcc` by downloading source and compiling gcc and it's dependencies. After that, add $HOME/norm/bin to your PATH and you can use your shiny new gcc.

You'll be surprised how much software you can install this way.

***

##Adding new package

 * Create a file in `packages` directory.
 * Add `fetch_source` line first.
 * Add `depends_on` lines if neccessary.
 * Add `do_unpack_compile` line.

Example:
```bash
#!/bin/bash
fetch_source http://ftpmirror.gnu.org/tar/tar-1.28.tar.gz cd30a13bbfefb54b17e039be7c43d2592dd3d5d0

depends_on libacl libattr

do_unpack_compile tar-1.28 tar-1.28.tar.gz
```

For more examples, see existing packages.

***

Since the variability of systems the code will be built on is big, please try to bring every dependency with the package, except for glibc, gcc and binutils.

Alternatively, don't build with rarely used features (like kerberos in openssh or ldap in curl).
