<div align="center">
  <h1>dotfiles</h1>
  <p>
    <strong>My personal Arch Linux dotfiles with a post-install script to set things up</strong>
  </p>


| Software | Choice | Note
| ------------- |:-------------:|-------------|
| Window Manager | [i3](https://wiki.archlinux.org/title/I3) | 
| Display Manager | [ly](https://github.com/fairyglade/ly) | 
| Status Bar | [polybar](https://github.com/jaagr/polybar) | 
| Launcher | [rofi](https://wiki.archlinux.org/index.php/rofi) | 
| Terminal      | [alacritty](https://github.com/alacritty/alacritty) | with Bash as shell & [starship](https://starship.rs/) as shell prompt
| Editor      | [helix](https://github.com/helix-editor/helix) | 
| File Manager | [lf](https://github.com/gokcehan/lf) | terminal file manager


</div>


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

In my hotkey setup I try to use the following logic as much as possible


##### Modifier keys

- `Super` For OS/WM
- `Ctrl` For windows in a application
- `Alt` For tabs in a application


##### Movement

- **ControlKey + j** Switch to left application/window/tab
- **ControlKey + k** Switch to bottom application/window/tab
- **ControlKey + l** Switch to top application/window/tab
- **ControlKey + ;** Switch to right application/window/tab


##### Move position focussed application/window/tab

- **ControlKey + shift + j** Move current application/window/tab one left
- **ControlKey + shift + k** Move current application/window/tab one bottom
- **ControlKey + shift + l** Move current application/window/tab one top
- **ControlKey + shift + ;** Move current application/window/tab one right


##### Other

- **ControlKey + o** Open application/window/tab
- **ControlKey + n** New application/window/tab
- **ControlKey + q** Close current application/window/tab

