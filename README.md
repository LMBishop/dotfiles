# dotfiles

Dotfiles for my machines. These configurations have been tested on a regular PC, M1 Mac running Asahi Linux, and even a Steam Deck. 

## Programs

This repository contains configurations for the following programs, intended to be run on either Arch Linux or Asahi Linux (/Arch Linux ARM). Some (but not all) configurations will also work without any further editing on macOS.

### Text-based

* [git](https://git-scm.com/)
* [neovim](https://neovim.io/) (*editor*)
    * [onedark.vim](https://github.com/joshdick/onedark.vim) (*theme*)
    * [vim-airline](https://github.com/vim-airline/vim-airline) (*status bar*)
* [tmux](https://github.com/tmux/tmux) (*multiplexer*)
* [zsh](https://www.zsh.org/) (*shell*)
    * [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

### Graphical

* [alacritty](https://alacritty.org/) (*terminal emulator*)
* [mako](https://github.com/emersion/mako) (*notifications*)
* [sway](https://swaywm.org/) (*WM*)
* [swaylock](https://github.com/swaywm/swaylock)
* [swayidle](https://github.com/swaywm/swayidle)
* [waybar](https://github.com/Alexays/Waybar) (*status bar*)
* [wofi](https://sr.ht/~scoopta/wofi/) (*launcher*)
* ~~[iTerm2](https://iterm2.com/)~~ (*terminal emulator, not currently in use*)
* ~~[rofi](https://github.com/davatorium/rofi)~~ (*launcher, not currently in use*)

## Install

This repository is designed to be installed with my own [dotfiles-installer](https://github.com/LMBishop/dotfiles-installer) program. Unless you happen to be me, I wouldn't suggest using this.

Arch / Asahi:
```
$ dotfiles-installer -f install-arch.yml
```

macOS - requires the Xcode command line tools:

```
$ dotfiles-installer -f install-macos.yml
```

## Screenshots
![](https://i.imgur.com/g6X81bT.png)
![](https://i.imgur.com/V1agzcF.png)
![](https://i.imgur.com/I08qlCp.png)
![](https://i.imgur.com/rBTh9WD.png)