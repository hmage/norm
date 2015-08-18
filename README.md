# Norm

Don't have root? Not a problem — `norm` will install stuff rootlessly into your home directory.

All you need is a working compiler.

## Quickstart

```bash
git clone https://github.com/hmage/norm ~/norm
. ~/norm/.bashrc
norm install ffmpeg
```

All neccessary dependencies to compile `ffmpeg` will be automatically done for you. It will take a while, but after everything is done, you will have `ffmpeg` in `~/norm.$MACHTYPE.$GLIBC_VERSION`. You can add that directory into your `PATH` manually, or you can use bashrc helper to do it for you — add this line to your `.bashrc`:

```bash
[[ -e ~/norm/.bashrc ]] && . ~/norm/.bashrc
```

## More examples
 * [`norm install gcc`](packages/gcc) — downloads, compiles and installs gcc 4.9.2. Great way to try out without touching your system.
 * [`norm install ffmpeg`](packages/ffmpeg) — if you're on Ubuntu or Debian, then your ffmpeg can be either _very_ outdated or not present at all. This will get you the newest ffmpeg with support for x264, x265, webm, opus and AAC.
 * [`norm install git`](packages/git) — similarly, your system copy of git might not support new features like push to deploy, reference cloning and shallow cloning.
 * [`norm install dovecot`](packages/dovecot) — you don't need root to spin up your own IMAP server, either. Change the listening port to something higher than 1024, set up virtual accounts and you're good to go.
 * [`norm install mc`](packages/mc) — latest midnight commander is much nicer than it was a few years ago.
 * [`norm install openssh`](packages/openssh) — your system openssh client might not support ECDSA and ed25519, which is increasingly problematic as the world around you moves away from DSA and RSA.
 * [`norm install aria2`](packages/aria2) — this is much nicer than curl or wget and can do parallel downloads.
 * [`norm install go`](packages/go) — you don't need root to have go language, either.
## About

`norm` installs formulas to your home directory, leaving system-wide programs intact and untouched. By default, install prefix is `~/norm.$MACHTYPE.$GLIBC_VERSION`, but you can change that. See output of `norm --help`.

The compiled binaries will not work properly on older version of glibc or in another location, they also might hardcode the user ID or name they were built with, so please treat them as your own personal builds (which they are).

Since `norm` uses `curl`, `wget`, and `aria2c` to download, it supports proxies. Just set up appropriate environment variables if you already haven't done so, like this:

```bash
export http_proxy=http://192.168.20.99:8080/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
```

Replace the IP address and port number with appropriate values for your proxy. You can add this to your `.bashrc` if you haven't done so.

## Adding new formulas
`norm` formulas are bash scripts, here's a pretty [minimal example](packages/tar):

```bash
#!/bin/bash
depends_on libacl libattr

fetch_source http://ftpmirror.gnu.org/tar/tar-1.28.tar.gz cd30a13bbfefb54b17e039be7c43d2592dd3d5d0
do_unpack_compile
```

To simplify these formulas, `norm` provides functions that reduce number of lines required to build most software:
 * `depends_on` — does the listed formulas.
 * `fetch_source` — downloads the source and verifies SHA1 checksum.
 * `do_unpack_compile` — unpacks the source code, runs `configure`, `make` and `make install`.

If software uses autotools to configure itself, no other bash functions are needed to successfully compile. There are [other functions](norm_common.functions) in case you need to do more, their names and comments should be self explanatory.

To see a complex example, you can take a look at [how gcc is built](packages/gcc) with in-tree compilation of it's dependencies.

If you want some formula to be added to `norm`, you can either let me know by [opening an issue](https://github.com/hmage/norm/issues) telling me that you'd like to see X or Y added to norm.

[Patches welcome](mailto:hmage@hmage.net).

You can also, of course, fork the source, add the package yourself and then [open a pull request here](https://github.com/hmage/norm/compare).
