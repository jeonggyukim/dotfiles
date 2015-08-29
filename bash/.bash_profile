# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

######################################################################
# Sample from Advanced Bash-Scripting guide:
# http://tldp.org/LDP/abs/html/sample-bashrc.html
######################################################################
TERM=xterm
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
set -o ignoreeof # Disable Ctrl + D for exit

# Reference for shopt
# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# Enable options:
shopt -s cdspell # correct the typos in the cd command automatically
shopt -s checkwinsize # terminals wrap lines correctly after resizing them
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

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


source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh
PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '   # adjust this to your prompt liking


# For ipython notebook locale
# Ref: http://stackoverflow.com/questions/15526996/ipython-notebook-locale-error
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# pythonpath
export PYTHONPATH=$PYTHONPATH:~/Dropbox/py/module:~/Dropbox/hii/py/modules

# MacPorts Installer addition on 2014-08-28_at_21:45:16: adding an
# appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# bookmarks.sh script
# Note that the use of bookmarks.sh script requires bash4.0+
source ~/dotfiles/bookmarks/bookmarks.sh
export PATH="/usr/local/bin:/Users/jgkim/bin:$PATH"

# added by Anaconda 2.0.1 installer
export PATH="/Users/jgkim/anaconda/bin:$PATH"

# idl setup
#source ~/Applications/exelis/idl83/bin/idl_setup.bash
export IDL_STARTUP=~/.idlstartup.pro

export CSCOPE_EDITOR=`which emacs`
