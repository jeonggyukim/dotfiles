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

## Useful scripts

* bookmarks
  * bookmarks.sh : bookmark management system for the Bash version 4.0+.
  * source : https://github.com/jcisio/bookmarks , https://lug.fh-swf.de/shell/

* colormake
  * colormake.sh : colorize make output.
  * source : https://github.com/renatosilva/colormake
