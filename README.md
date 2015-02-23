# Non-root package manager

Don't have root? Not a problem.

NORM installs stuff you need that your sysadmin didn't — it installs packages to your home directory, leaving system-wide programs intact and untouched (you probably don't have permissions to change them anyway).

If your compiler works and can compile a simple "hello world" program, you can compile [any package listed here](https://github.com/hmage/norm/tree/master/packages). 

If you don't have root, it's very likely that software you want to use isn't the latest version. And, in some cases, downloading binaries won't help — your libc might be too old to run them.

After installation, add `$HOME/norm/bin` in front of your PATH to run your own versions of programs you've just installed.

## Examples
 * [`norm install gcc`](https://github.com/hmage/norm/tree/master/packages/gcc) — downloads, compiles and installs gcc 4.9. Great way to try out new compiler.
 * [`norm install ffmpeg`](https://github.com/hmage/norm/tree/master/packages/ffmpeg) — if you're on Debian wheezy, then your ffmpeg is _very_ outdated. This will gets you the newest ffmpeg with support for x264, x265, webm, opus and AAC.
 * [`norm install git`](https://github.com/hmage/norm/tree/master/packages/git) — similarly, your system copy of git might not support new features like push to deploy, reference cloning and shallow cloning.
 * [`norm install dovecot`](https://github.com/hmage/norm/tree/master/packages/dovecot) — you don't need root to spin up your own IMAP server, either. Change the listening port to something higher than 1024, set up virtual accounts and you're good to go.
 * [`norm install mc`](https://github.com/hmage/norm/tree/master/packages/mc) — latest midnight commander is much nicer than it was a few years ago, don't be stuck in the past.
 * [`norm install openssh`](https://github.com/hmage/norm/tree/master/packages/openssh) — your system openssh client might not support ECDSA and ed25519, which is increasingly problematic as the world around you moves away from DSA and RSA.
 * [`norm install fontconfig`](https://github.com/hmage/norm/tree/master/packages/fontconfig) — if font rendering on your machine looks horrible, install this, set up `LD_LIBRARY_PATH` to `~/norm/lib` in bashrc (before interactive check cutoff) and restart X session.
 * [`norm install virtual/forchrome`](https://github.com/hmage/norm/tree/master/packages/virtual/forchrome) — You want a shiny new chrome and don't have root? First, install this, then set up `LD_LIBRARY_PATH` like above, then download chrome binary from official site and run `./chrome —no-sandbox`. Voila, you have latest chrome with latest flash.

## Packages
NORM packages are bash scripts, here's an example:

```bash
#!/bin/bash
depends_on libacl libattr

fetch_source http://ftpmirror.gnu.org/tar/tar-1.28.tar.gz cd30a13bbfefb54b17e039be7c43d2592dd3d5d0
do_unpack_compile
```

 * `depends_on` — these packages will be compiled if they aren't yet.
 * `fetch_source` — fetches source using curl and verifies SHA1 checksum.  
 (Or just verifies the SHA1 checksum).
 * `do_unpack_compile` — unpacks the source code, runs `configure` with prefix set to `~/norm`, then `make` and `make install`.

If software uses autotools to configure itself, no other bash functions are needed to successfully compile. [Other functions](https://github.com/hmage/norm/blob/master/norm_common.functions) should be self explanatory.

To see more complex example, check [gcc 4.9 package script](https://github.com/hmage/norm/tree/master/packages/gcc).

## Hardcoded paths

The compiled binaries are not for distribution — compiled executables have hardcoded paths and they won't work in any other location or machine.

## Proxies

Since `norm` uses `curl` to download source code, it supports proxies. Just set up appropriate environment variable in `.bashrc` if you already haven't done so, like this:

```bash
export http_proxy=http://192.168.20.99:8080/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
```

Replace the IP and port with appropriate values.

# Adding new packages

[I'm open to pull requests](https://github.com/hmage/norm/compare).
