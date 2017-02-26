## HOWTO:

* Clone repository to ~/dotfiles

  `git clone https://github.com/omyojj/dotfiles.git`

* Install [GNU stow](https://www.gnu.org/software/stow/)

  - OSX
    `$ brew [cask] install stow`

* Invoke stow command
  - Example, if you want to stow emacs init files:
    `mkdir ~/.emacs.d ; cd ~/dotfiles ; stow emacs`
    
    This will create symbolik links for ~/dotfiles/emacs/.emacs.d/init.el, etc. in ~/.emacs.d/
    
  - [How to invoke stow](https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow)

---

## Directories

* bash_osx
  * .bash_profile : bash startup For MacOSX since iTerm is configures to start as a login shell. Should be merged with bashrc later.

* bashrc
  * .bashrc : For linux.
  * .bash_aliases: aliases (used both in linux and osx)

* colormake
  * colormake.sh : colorize make output.
  * original(?) source : https://github.com/renatosilva/colormake

* emacs: My emacs configuration. Includes init.el and myinit.org. Better to have emacs version >24.5 for smooth org installation.
  * create ~/.emacs.d directory before stowing.

* git: .git-completion.bash, .git-prompt.sh, .gitconfig, .gitignore_global

* ssh: ssh config
  * create ~/.ssh directory before stowing.
