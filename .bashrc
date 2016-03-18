## add this to your .bashrc
## [ -f $HOME/work/norm/.bashrc ] && . $HOME/work/norm/.bashrc

## since we use -march=native, i7 binaries won't run on core2 -- add arch to machine id
GCCARCH=$(gcc -march=native -Q --help=target 2>&1 | grep -- '^ *-march=' | awk '{ print $2 }')

## get machine id for later
case $OSTYPE in
    *linux*)   SYSTEM_VERSION=.$(getconf GNU_LIBC_VERSION|awk '{ print $NF }') ;; #$($(ldd /bin/sh|fgrep /libc.so|awk '{ print $3 }') | fgrep 'GNU C Library'|perl -pe 's/GNU C Library.*version ([^ ,]+).*/$1/') ;;
    *freebsd*) SYSTEM_VERSION= ;;
    *openbsd*) SYSTEM_VERSION= ;;
    *darwin*)  SYSTEM_VERSION= ;;
    *)        SYSTEM_VERSION=.unknown ;;
esac
MACHINEID="${BASH_VERSINFO[5]}$SYSTEM_VERSION"
[ -n "$GCCARCH" ] && MACHINEID+=".$GCCARCH"
[ -z "${debian_chroot:-}" -a -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
[ -n "$debian_chroot" ] && MACHINEID+=".$debian_chroot"
unset SYSTEM_VERSION GCCARCH

NORMPREFIX="$HOME/norm.$MACHINEID"
DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

addpath() {
    [ -z "$1" -o -z "$2" ] && return
    local value VARNAME=$1
    shift
    for value; do
        [ -z "${!VARNAME}" ] && export $VARNAME="$value" && continue
        [[ ! "${!VARNAME}" =~ "(^|:)$value(:|$)" ]] && export $VARNAME="$value:${!VARNAME}"
    done
}

## add ourselves to the PATH if we're not there yet
addpath PATH "$DIR" "$NORMPREFIX/bin" "$NORMPREFIX/sbin" "$NORMPREFIX/bin/ccache_wrap"

unset -f addpath
