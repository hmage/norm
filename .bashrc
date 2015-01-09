## add this to your .bashrc
## [ -f $HOME/work/norm/.bashrc ] && . $HOME/work/norm/.bashrc

DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
export PATH="$HOME/norm/bin/ccache_wrap:$HOME/norm/bin:$DIR:$PATH"
