<div align=center>
<h1>nixfiles</h1>
</h2><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="500" />
<p></p>
  <img src="https://img.shields.io/github/stars/skiletro/nixfiles?color=f5c2e7&labelColor=303446&style=for-the-badge&logo=starship&logoColor=f5c2e7">
  <img src="https://img.shields.io/github/repo-size/skiletro/nixfiles?color=fab387&labelColor=303446&style=for-the-badge&logo=github&logoColor=fab387">
 <p></p>
 <img src="https://i.imgur.com/zSs7456.png"></img>
 <p>Screenshot last updated November 3rd, 2023</p>
</div>

My dotfiles that I used on my arch-based system can be found [here](https://github.com/skiletro/archfiles), and are a basis for a lot of the configuration here! If you don't use NixOS, you can probably find a more standard config for the thing you are looking for over there.

## Goals
- Wayland first
- Looks pretty

## Installation Guide (WIP)
- Enter a nix-shell with `nix-shell -p alejandra git neovim`
- Clone the repo (preferably under `.nix_config` in your home directory
- Copy over your `configuration.nix` and `hardware-configuration.nix` to a new folder in `machines/`.
- Rename `configuration.nix` to `default.nix`
- Add the host to the list of hosts in `flake.nix`
- Change all the user references from `jamie` to whatever username you are using
- Run `nix develop --extra-experimental-features "flakes nix-command"` then type `rebuild` (you might need to run it another time for it to fully do its thing)

## Issues
- [ ] **SwayNC:** Fix small padding issue on notifications on the right hand of the screen

## Todo
- [ ] Some sort of wallpaper script/system, prob using [lutgen](https://github.com/ozwaldorf/lutgen-rs)

If you can help with any of this stuff, please do a pull request as I am still learning!
