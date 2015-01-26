## add this to your .bashrc
## [ -f $HOME/work/norm/.bashrc ] && . $HOME/work/norm/.bashrc

NORMPREFIX="$HOME/norm"
DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

addpath() {
    [ -z "$1" ] && return
    [ -z "$PATH" ] && export PATH="$1" && return
    [[ ! "$PATH" =~ (^|:)"$1"(:|$) ]] && export PATH="$1:$PATH"
}

## add ourselves to the PATH if we're not there yet
addpath "$DIR"
addpath "$NORMPREFIX/bin"
addpath "$NORMPREFIX/bin/ccache_wrap"

unset -f addpath
