# Non-root package manager

Don't have root? Not a problem.

If your compiler works and can compile a simple "hello world" program, you can compile [any package listed here](https://github.com/hmage/norm/tree/master/packages). 

If you don't have root, it's very likely that software you want to use isn't the latest version. And, in some cases, downloading binaries won't help -- your libc might be too old to run them.

## Examples
 * `norm install gcc` -- downloads, compiles and installs gcc 4.9. Great way to try out new compiler.
 * `norm install ffmpeg` -- if you're on Debian wheezy, then your ffmpeg is _very_ outdated. This will gets you the newest ffmpeg with support for x264, x265, webm, opus and AAC.
 * `norm install git` -- similarly, your system copy of git might not support new features like push to deploy, reference cloning and shallow cloning.
 * `norm install fetchmail maildrop dovecot` -- you don't need root to spin up your own IMAP server, either. Change the listening port to something higher than 1024, set up virtual accounts and you're good to go.
 * `norm install mc` -- latest midnight commander is much nicer than it was a few years ago, don't be stuck in the past.
 * `norm install openssh` -- your system openssh client might not support ECDSA and ed25519, which is increasingly problematic as the world around you moves away from DSA and RSA.
 * `norm install fontconfig` -- if font rendering on your machine looks horrible, install this, set up `LD_LIBRARY_PATH` to `~/norm/lib` in bashrc (before interactive check cutoff) and restart the app.
 * `norm install virtual/forchrome` -- You want a shiny new chrome and don't have root? First, install this, then set up `LD_LIBRARY_PATH` like above, then download chrome binary from official site and run `./chrome --no-sandbox`. Voila, you have latest chrome with latest flash.

## Hardcoded paths

The compiled binaries are not for distribution -- compilation process adds hardcoded paths to them and won't work in any other location.

## Proxies

Since `norm` uses `curl` to download source code, it supports proxies. Just set up appropriate environment variable in `.bashrc` if you already haven't done so, like this:

```bash
export http_proxy=http://192.168.20.99:8080/
export https_proxy=http://192.168.20.99:8080/
export ftp_proxy=http://192.168.20.99:8080/
```

Replace the IP and port with appropriate values.

# Adding new package

Package files are just bash scripts, this is a bare minimum example:

```bash
#!/bin/bash
depends_on libacl libattr

fetch_source http://ftpmirror.gnu.org/tar/tar-1.28.tar.gz cd30a13bbfefb54b17e039be7c43d2592dd3d5d0
do_unpack_compile
```

 * `depends_on` -- executes other package scripts.
 * `fetch_source` -- downloads the source code using curl and verifies SHA1 checksum. 
    (If it's already downloaded, just verifies the SHA1 checksum).
 * `do_unpack_compile` -- unpacks the source code, runs configure with prefix set to `~/norm`, then make and then make install.

Most software only needs these commands to successfully compile. For see more complex package scripts, go [here](https://github.com/hmage/norm/tree/master/packages).

I'm open to pull requests.
