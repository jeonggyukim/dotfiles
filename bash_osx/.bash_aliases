#!/bin/bash
# ~/.bash_aliases

#alias mkdir='mkdir -p'
#alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i' # Prevents accidentally clobbering files.
alias ..='cd ..'

alias ls='ls -h'
# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lF" # --group-directories-first"
alias la='ll -Aa' #  Show hidden files
alias ld='ls -ld */' # show only directories
alias l='ls -CF'

alias grep='grep --color=always'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias e='emacs -nw'
alias em='emacs'
alias ems='e ms.tex'
alias emms='em ms.tex&'
alias evms='ev ms.pdf&'

alias s='ssh'

# emacs readonly mode
emr() {
  emacs "$1" --eval '(setq buffer-read-only t)'
}

er() {
  emacs -nw "$1" --eval '(setq buffer-read-only t)'
}

alias evince='skim'
alias ev='evince'
alias mk='make'

alias ipynb='ipython notebook'
alias jpynb='jupyter notebook'
alias jpynbnb='jupyter notebook --no-browser'

alias eem='emacs -nw ~/.emacs'
alias ebash='emacs -nw ~/.bash_profile'
alias sbash='source ~/.bash_profile'
alias ealias='emacs -nw ~/.bash_aliases'
alias eidl='emacs -nw ~/.idlstartup.pro'

# How to use Terminal to speed up OS X
# Reference:
# http://www.macworld.com.au/help/how-to-use-terminal-to-speed-up-mountain-lion-70147/
alias dashon='defaults write com.apple.dashboard mcx-disabled -boolean NO; killall Dock'
alias dashoff='defaults write com.apple.dashboard mcx-disabled -boolean YES; killall Dock'
alias animationon='defaults delete com.apple.dock expose-animation-duration; killall Dock'
alias animationoff='defaults write com.apple.dock expose-animation-duration -int 0; killall Dock'
alias dock2d='defaults write com.apple.dock no-glass -boolean NO; killall Dock'
alias quitfinderon='defaults write com.apple.finder QuitMenuItem -bool YES; killall Finder'
alias quitfinderoff='defaults write com.apple.finder QuitMenuItem -bool NO; killall Finder'


#defaults write org.python.python NSAppSleepDisabled -bool YES
