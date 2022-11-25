My personal dotfiles with a post-install script to set things up

- wm: i3
- dm: ly
- rofi
- polybar
- alacritty
- helix
- qutebrowser

## Getting started


#### 1 - Install Arch Linux

I recommend using the guided installer 'archinstall'

- [archinstall - ArchWiki](https://wiki.archlinux.org/title/Archinstall)


#### 2 - Excecute install script

``` bash
curl -LO https://raw.githubusercontent.com/TristanJSchoenmakers/dotfiles/main/install.sh

bash install.sh
```


## Hotkeys

In my hotkey I try to use the following logic as much as possible

The `Super` Control Key is for OS/WM hotkeys

The `Control` Control Key is for windows in application

The `Alt` Control Key is for tabs in a application


##### Movement

- **ControlKey + j** Switch to left application/window/tab
- **ControlKey + k** Switch to bottom application/window/tab
- **ControlKey + l** Switch to top application/window/tab
- **ControlKey + ;** Switch to right application/window/tab


##### Changing position

- **ControlKey + shift + j** Move current application/window/tab one left
- **ControlKey + shift + k** Move current application/window/tab one bottom
- **ControlKey + shift + l** Move current application/window/tab one top
- **ControlKey + shift + ;** Move current application/window/tab one right


##### Other

- **ControlKey + o** Open application/window/tab
- **ControlKey + n** New application/window/tab


## Sources

- [Make a post installation script](https://www.addictivetips.com/ubuntu-linux-tips/make-ubuntu-post-installation-script/)
- [Remove default folders](https://weibeld.net/linux/remove-default-folders.html)
