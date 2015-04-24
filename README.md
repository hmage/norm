# Norm

Don't have root?

Not a problem — `norm` installs stuff you need that your sysadmin didn't.

All you need is a working compiler.

## Quickstart

```bash
git clone https://github.com/hmage/norm ~/norm
. ~/norm/.bashrc
norm install gcc
```

After everything is done, you will have gcc 5.1 in `~/norm` with all it's dependencies, like this:

![Example of gcc-5.1 output](http://hmage.github.io/norm/images/gcc-5.1.png)

You can add everything installed by `norm` into your `PATH` manually or you can use bashrc helper to do it for you — add this line to your `.bashrc`:

```bash
[[ -e ~/norm/.bashrc ]] && . ~/norm/.bashrc
```

## More examples
 * [`norm install gcc`](packages/gcc) — downloads, compiles and installs gcc 5.1. Great way to try out new compiler.
 * [`norm install ffmpeg`](packages/ffmpeg) — if you're on Debian wheezy, then your ffmpeg is _very_ outdated. This will gets you the newest ffmpeg with support for x264, x265, webm, opus and AAC.
 * [`norm install git`](packages/git) — similarly, your system copy of git might not support new features like push to deploy, reference cloning and shallow cloning.
 * [`norm install dovecot`](packages/dovecot) — you don't need root to spin up your own IMAP server, either. Change the listening port to something higher than 1024, set up virtual accounts and you're good to go.
 * [`norm install mc`](packages/mc) — latest midnight commander is much nicer than it was a few years ago, don't be stuck in the past.
 * [`norm install openssh`](packages/openssh) — your system openssh client might not support ECDSA and ed25519, which is increasingly problematic as the world around you moves away from DSA and RSA.
 * [`norm install fontconfig`](packages/fontconfig) — if font rendering on your machine looks horrible, install this, set up `LD_LIBRARY_PATH` to `~/norm/lib` in your `.bashrc` (before interactive check cutoff) and restart X session.

## About

`norm` installs packages to your home directory, leaving system-wide programs intact and untouched — you probably don't have permissions to change them anyway. By default, install prefix is `~/norm`, but you can change that. See output of `norm --help`.

The compiled binaries are not for distribution — they won't work on any other location or another machine (because most programs hardcode their paths during compilation and add checks to glibc version used for building).

Since `norm` uses `curl` to download source code, it supports proxies. Just set up appropriate environment variables if you already haven't done so, like this:

```bash
export http_proxy=http://192.168.20.99:8080/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
```

Replace the IP address and port with appropriate values for your proxy. You can add this to your `.bashrc` if you haven't done so.

## Packages
`norm` packages are bash scripts, [example](packages/tar):

```bash
#!/bin/bash
depends_on libacl libattr

fetch_source http://ftpmirror.gnu.org/tar/tar-1.28.tar.gz cd30a13bbfefb54b17e039be7c43d2592dd3d5d0
do_unpack_compile
```

This particular packages uses only commands that are specific to `norm`:
 * `depends_on` — compiles the listed packages first.
 * `fetch_source` — downloads the source and verifies SHA1 checksum.
 * `do_unpack_compile` — unpacks the source code, runs `configure`, `make` and `make install`.

If software uses autotools to configure itself, no other bash functions are needed to successfully compile. [Other functions](norm_common.functions) should be self explanatory.

To see a more complex example, you can take a look at [how gcc is built](packages/gcc).

## Adding new packages

If you want some package to be added to `norm`, you can either let me know by [opening an issue](https://github.com/hmage/norm/issues) or you can do it yourself and then [open a pull request](https://github.com/hmage/norm/compare).
