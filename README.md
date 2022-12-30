NORM — Non-root build Manager
=============================

 * Don't have root privileges?
 * Don't want to wait for your sysadmin to install something trivial like new version of midnight commander?
 * Sysadmins don't have new version of gcc or don't know how to install it?

Not a problem!

`norm` will download, compile and install stuff into a directory in your home folder without requiring superuser access.

## Quickstart

```bash
git clone https://github.com/hmage/norm ~/norm
echo '[ -f $HOME/norm/.bashrc ] && . $HOME/norm/.bashrc' >> ~/.bashrc
. ~/norm/.bashrc
norm install mc
```

After waiting a bit, you'll get a fresh version of `mc` in your `$PATH`. Just type `mc` to start using it.

`norm` places everything it builds into a subdirectory in your home folder.

To prevent problems with NFS-shared homes, it puts system identification in the subdirectory's name, for example on Linux with glibc version 2.19 and Haswell CPU, the name will be `norm.x86_64-pc-linux-gnu.2.19.haswell`.

## How it's done

`norm` downloads the source code and compiles almost all dependencies. This is to avoid problems when some application (for example `aria2`) detects that a system has an optional library (for example `libpsl`) but fails to compile, because the system-provided library is too old.

Please be aware that binaries that `norm` installs are not portable — the expected paths are usually absolute — just like `/usr`, but for example in my case it'll be `/home/hmage/norm.x86_64-pc-linux-gnu.2.19.haswell`.

Moving binaries around will most certainly break them.

Please treat them as your own personal builds (which they are).

## Proxies

Since `norm` uses `curl`, `wget`, and `aria2c` to download, you can use proxies. Just set up the usual environment variables, like this:

```bash
export http_proxy=http://192.168.20.99:8080/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
```

Replace the IP address and port number with appropriate values for your proxy. You can add this to your `.bashrc` if you haven't done so.

## Formula format

`norm` formulae are bash scripts, here's a [working example](https://github.com/hmage/norm/blob/master/packages/gzip):

```bash
#!/bin/bash

fetch_source http://ftpmirror.gnu.org/gzip/gzip-1.12.tar.gz 91fa501ada319c4dc8f796208440d45a3f48ed13

do_unpack_compile
```

And that's it. It will download, unpack, run `./configure` with proper parameters, then `make` and `make install` into installation prefix that is located in user's home directory.

## More examples

 * [`norm install ffmpeg`](https://github.com/hmage/norm/blob/master/packages/ffmpeg) — if you're on Ubuntu or Debian, then your `ffmpeg` version can be either _very_ outdated or not present at all. This will get you the newest ffmpeg with support for x264, x265, webm, opus and `fdk-aac`.
 * [`norm install mc`](https://github.com/hmage/norm/blob/master/packages/mc) — latest midnight commander is much nicer than it was a few years ago.

## Adding new formula

To simplify creating the formula, `norm` provides functions that reduce amount of typing needed for building most software:
 * `depends_on` — will build the mentioned formulae.
 * `fetch_source` — downloads the source and verifies checksum.
 * `do_unpack_compile` — unpacks the source code and builds it.

There are more, but these are the most commonly needed.

If source code uses autotools or cmake, `norm` detects that and compiles appropriately.

If the build system is something else, or extra steps are needed to successfully build the formula, there are [other functions](https://github.com/hmage/norm/blob/master/norm_common.functions) provided, their names and comments should be self explanatory.

To see a more complex example, take a look at [how go is built](https://github.com/hmage/norm/blob/master/packages/go).

## Reporting bugs

See https://github.com/hmage/norm/issues.

Also, you can contact me at [hmage@hmage.net](mailto:hmage@hmage.net).
