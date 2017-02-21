## HOWTO:

* Clone repository to ~/dotfiles

  `git clone https://github.com/omyojj/dotfiles.git`

* Install [GNU stow](https://www.gnu.org/software/stow/)

  - OSX
    `brew install stow`

  - [How to invoke stow](https://www.gnu.org/software/stow/manual/stow.html#Invoking-Stow)

---

## Directories

* bash_osx
  * .bash_profile : bashrc for MacOSX. Should be merged with bashrc later.

* bashrc
  * .bash_profile : bash For MacOSX

* emacs: My emacs configuration. Contains init.el and myinit.org. Better to have emacs version >24.5
  * create ~/.emacs.d directory before stowing.

* ssh: ssh config
  * create ~/.ssh directory before stowing.
