# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

######################################################################
# Sample from Advanced Bash-Scripting guide:
# http://tldp.org/LDP/abs/html/sample-bashrc.html
######################################################################
TERM=xterm-256color
bind -f ~/.inputrc

# Change default editor
export EDITOR="/usr/local/bin/emacs -nw"

[ -z "$PS1" ] && return # If not running interactively, don't do anything

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTSIZE=20000     # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTFILESIZE=40000

# These two options are useful for debugging.
alias debug="set -o nounset; set -o xtrace"
set -o notify
set -o noclobber
#set -o ignoreeof # Disable Ctrl + D for exit

# Reference for shopt
# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# Enable options:
shopt -s cdspell # correct the typos in the cd command automatically
shopt -s checkwinsize # terminals wrap lines correctly after resizing them
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.
if [ "${BASH_VERSINFO}" -ge 4 ]; then
    shopt -s autocd
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Disable options:
shopt -u mailwarn
unset MAILCHECK

export CLICOLOR=1
#export LSCOLORS=gxfxcxdxbxegedabagacad
#export LSCOLORS=Exfxcxdxbxegedabagacad
export LSCOLORS=GxFxCxDxBxegedabagaced

# # Alias definitions.
# # You may want to put all your additions into a separate file like
# # ~/.bash_aliases, instead of adding them here directly.
# # See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

## For git settings
source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '   # adjust this to your prompt liking

############################################


# For ipython notebook locale
# Ref: http://stackoverflow.com/questions/15526996/ipython-notebook-locale-error
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# pythonpath
export PYTHONPATH="$HOME/Dropbox/gmc/py/athpy:$HOME/Dropbox/gmc/py/athpy_gmc:$PYTHONPATH"
export PYTHONPATH="$HOME/Dropbox/tigrad/py/tigradpy:$PYTHONPATH"
export PYTHONSTARTUP="$HOME/.pythonrc.py"

# bookmarks.sh script
# Note that the use of bookmarks.sh script requires bash4.0+
source ~/dotfiles/bookmarks/bookmarks.sh

export CSCOPE_EDITOR=$(which emacs)

## idl setup
#source ~/Applications/exelis/idl83/bin/idl_setup.bash
#export IDL_STARTUP=~/.idlstartup.pro

export MATPLOTLIB="/Users/jgkim/.matplotlib"

export PATH="/Users/jgkim/anaconda2/bin:$PATH"
export PATH="/usr/local/bin:/Users/jgkim/bin:$HOME/Dropbox/gmc/py/athpy_gmc/w1:$PATH"

# Add VisIt directory
export PATH="/Applications/ParaView-5.3.0-RC3.app/Contents/MacOS:/Applications/VisIt.app/Contents/Resources/bin:$PATH"

# paraview lib, python path
#export DYLD_LIBRARY_PATH="/Applications/ParaView-5.3.0-RC3.app/Contents/Libraries:$DYLD_LIBRARY_PATH"
#export PYTHONPATH="/Applications/ParaView-5.2.0.app/Contents/Python/paraview:$PYTHONPATH"

# SLUG
#export CPLUS_INCLUDE_PATH="/usr/local/Cellar/boost/1.63.0:$CXX_INCLUDE_PATH"
export CXX_INCLUDE_PATH="/usr/local/Cellar/boost/1.63.0:$CXX_INCLUDE_PATH"
export C_INCLUDE_PATH="/usr/local/Cellar/gsl/2.3/include:$C_INCLUDE_PATH"
#export DYLD_LIBRARY_PATH="/usr/local/Cellar/boost/1.63.0/lib:$DYLD_LIBRARY_PATH"
#export DYLD_LIBRARY_PATH="/usr/local/Cellar/gsl/2.3/lib:$DYLD_LIBRARY_PATH"
export SLUG_DIR="$HOME/Documents/slug2"

alias mpirun="/usr/local/bin/mpirun"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# added by glueconda installer
#export PATH="/Users/jgkim/glueconda/bin:$PATH"


export DESPOTIC_HOME="/Users/jgkim/Dropbox/despotic"
