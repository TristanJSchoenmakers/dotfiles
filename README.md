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
| Text Editor      | [helix](https://github.com/helix-editor/helix) | 
| File Manager | [lf](https://github.com/gokcehan/lf) | terminal file manager


</div>


## Getting started


#### 1 - Install Arch Linux

I recommend using the guided installer 'archinstall'

- [archinstall - ArchWiki](https://wiki.archlinux.org/title/Archinstall)


#### 2 - Excecute install script
<span style="color:red;">WARNING! this will delete your current .config directory and replace it with my dotfiles!</span>

``` bash
# Run the following commands in your home directory (~/)
curl -LO https://raw.githubusercontent.com/TristanJSchoenmakers/dotfiles/main/install.sh

bash install.sh
```


## Hotkeys

In my hotkey setup I try to use the following logic as much as possible


##### Modifier keys

- `Super` For OS/WM related hotkeys
- `Ctrl` For windows within a application related hotkeys
- `Alt` For tabs in a application related hotkeys


##### Movement

- **ModifierKey + h** Switch to left application/window/tab
- **ModifierKey + j** Switch to bottom application/window/tab
- **ModifierKey + k** Switch to top application/window/tab
- **ModifierKey + l** Switch to right application/window/tab


##### Move position focussed application/window/tab

- **ModifierKey + shift + h** Move current application/window/tab one left
- **ModifierKey + shift + j** Move current application/window/tab one bottom
- **ModifierKey + shift + k** Move current application/window/tab one top
- **ModifierKey + shift + l** Move current application/window/tab one right


##### Other

- **ModifierKey + o** Open application/window/tab
- **ModifierKey + n** New application/window/tab
- **ModifierKey + q** Close current application/window/tab

