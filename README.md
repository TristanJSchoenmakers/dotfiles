<div align="center">
  <h1>dotfiles</h1>
  <p>
    <strong>My personal NixOs dotfiles</strong>
  </p>
</div>


## Getting started


#### 1 - Install NixOs

- [NixOs Download](https://nixos.org/download/)


#### 2 - Excecute install script

```bash
nix-shell -p curl
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

