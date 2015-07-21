## add this to your .bashrc
## [ -f $HOME/work/norm/.bashrc ] && . $HOME/work/norm/.bashrc

## get machine id for later
## get machine id for later
case $OSTYPE in
    *linux*)   SYSTEM_VERSION=.$(getconf GNU_LIBC_VERSION|awk '{ print $NF }') ;; #$($(ldd /bin/sh|fgrep /libc.so|awk '{ print $3 }') | fgrep 'GNU C Library'|perl -pe 's/GNU C Library.*version ([^ ,]+).*/$1/') ;;
    *freebsd*) SYSTEM_VERSION= ;;
    *openbsd*) SYSTEM_VERSION= ;;
    *darwin*)  SYSTEM_VERSION= ;;
    *)        SYSTEM_VERSION=.unknown ;;
esac
MACHINEID="${BASH_VERSINFO[5]}$SYSTEM_VERSION"
unset SYSTEM_VERSION

NORMPREFIX="$HOME/norm.$MACHINEID"
DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

addpath() {
    [ -z "$1" -o -z "$2" ] && return
    local value VARNAME=$1
    shift
    for value; do
        [ -z "${!VARNAME}" ] && export $VARNAME="$value" && continue
        [[ ! "${!VARNAME}" =~ (^|:)$value(:|$) ]] && export $VARNAME="$value:${!VARNAME}"
    done
}

## add ourselves to the PATH if we're not there yet
addpath PATH "$DIR" "$NORMPREFIX/bin" "$NORMPREFIX/sbin" "$NORMPREFIX/bin/ccache_wrap"

unset -f addpath
