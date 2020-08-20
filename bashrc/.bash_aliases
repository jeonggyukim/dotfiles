#!/bin/bash

#alias mkdir='mkdir -p'
#alias rm='rm -i'
if [[ $(uname -s) == "Linux" ]]; then
    alias rm='gvfs-trash'
elif [[ $(uname -s) == "Darwin" ]]; then
#    alias rm='trash'
    alias rm='rm'
fi

alias cp='cp -i'
alias mv='mv -i' # Prevents accidentally clobbering files.
alias ..='cd ..'

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lFh"
alias la='ll -Aah'           #  Show hidden files.
alias ld='ls -ldh */'
alias l='ls -CFh'

alias grep='grep --color=always'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


alias e='emacs -nw'
alias em='emacs'
alias eem='emacs -nw ~/.emacs.d/init.el'
alias emem='emacs ~/.emacs.d/init.el &'
alias einit='emacs -nw ~/.emacs.d/myinit.org'
alias eminit='emacs ~/.emacs.d/myinit.org &'

if [[ $(uname -s) == "Linux" ]]; then
    alias ebash='emacs -nw ~/.bashrc'
    alias sbash='source ~/.bashrc'
elif [[ $(uname -s) == "Darwin" ]]; then
    alias ebash='emacs -nw ~/.bash_profile'
    alias sbash='source ~/.bash_profile'
fi
alias ealias='emacs -nw ~/.bash_aliases'

alias ems='emacs -nw ms.tex'
alias emms='emacs ms.tex &'

alias ipy='ipython'
alias jpynb='jupyter notebook'
alias jpynbnb='jupyter notebook --no-browser'

if [[ $(uname -s) == "Darwin" ]]; then
    alias evince='skim'
fi
alias mk='make'
alias ev='evince'
alias s='ssh'

alias eidl='e ~/.idlstartup.pro'

# How to use Terminal to speed up OS X
# Reference:
# http://www.macworld.com.au/help/how-to-use-terminal-to-speed-up-mountain-lion-70147/
if [[ $(uname -s) == "Darwin" ]]; then
    alias dashon='defaults write com.apple.dashboard mcx-disabled -boolean NO; killall Dock'
    alias dashoff='defaults write com.apple.dashboard mcx-disabled -boolean YES; killall Dock'
    alias animationon='defaults delete com.apple.dock expose-animation-duration; killall Dock'
    alias animationoff='defaults write com.apple.dock expose-animation-duration -int 0; killall Dock'
    alias dock2d='defaults write com.apple.dock no-glass -boolean NO; killall Dock'
    alias quitfinderon='defaults write com.apple.finder QuitMenuItem -bool YES; killall Finder'
    alias quitfinderoff='defaults write com.apple.finder QuitMenuItem -bool NO; killall Finder'
fi


alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}


function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}
