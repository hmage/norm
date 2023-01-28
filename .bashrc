## add this to your .bashrc
## [ -f $HOME/work/norm/.bashrc ] && . $HOME/work/norm/.bashrc

## since we use -march=native, i7 binaries won't run on core2 -- add arch to machine id
GCCARCH=`(gcc -march=native -Q --help=target || true) 2>&1 | grep -- '^ *-march=' | awk '{ print $2 }' || true`
if [[ $GCCARCH == "" ]]; then
    GCCARCH=`clang -v -xc /dev/null -O3 -march=native -o- -E 2>&1 | grep -o 'target-cpu \w*'|awk '{print $2}'`
fi

## get machine id for later
LIBC_VERSION=
case $OSTYPE in
    *linux*)
        LIBC_VERSION=`(getconf GNU_LIBC_VERSION || true) 2>/dev/null|awk '{ print $NF }'`
        [[ -n $LIBC_VERSION ]] && LIBC_VERSION=".$LIBC_VERSION"
        ;;
esac
MACHINEID="${BASH_VERSINFO[5]}$LIBC_VERSION"
[ -n "$GCCARCH" ] && MACHINEID+=".$GCCARCH"
[ -z "${debian_chroot:-}" -a -r /etc/debian_chroot ] && debian_chroot=$(cat /etc/debian_chroot)
[ -n "$debian_chroot" ] && MACHINEID+=".$debian_chroot"
unset LIBC_VERSION GCCARCH

NORMPREFIX="$HOME/norm.$MACHINEID"
DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

norm_addpath() {
    [ -z "$1" -o -z "$2" ] && return
    local value VARNAME=$1
    shift
    for value; do
        [ -z "${!VARNAME}" ] && export $VARNAME="$value" && continue
        [[ ! "${!VARNAME}" =~ (^|:)$value(:|$) ]] && export $VARNAME="$value:${!VARNAME}"
    done
}

## add ourselves to the PATH if we're not there yet
norm_addpath PATH "$DIR" "$NORMPREFIX/bin" "$NORMPREFIX/sbin" "$NORMPREFIX/bin/ccache_wrap"
norm_addpath PERL5LIB "$NORMPREFIX/lib/perl5"

unset -f norm_addpath
unset DIR
