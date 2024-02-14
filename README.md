<div align=center>
<h3>
  <img src="https://i.imgur.com/tSwLTKE.png" height="100"/>
  <br/>
  nixfiles
</h3>
</h2><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="500" />
<p></p>
  <img src="https://img.shields.io/github/stars/skiletro/nixfiles?color=f5c2e7&labelColor=303446&style=for-the-badge&logo=starship&logoColor=f5c2e7">
  <img src="https://img.shields.io/github/repo-size/skiletro/nixfiles?color=fab387&labelColor=303446&style=for-the-badge&logo=github&logoColor=fab387">
 <p></p>
 <img src="https://i.imgur.com/RoA2Ahq.png"></img>
 <p>Screenshot last updated December 28th, 2023</p>
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
- **Eww:** Replace wlogout with custom eww power menu
- **Eww:** Rewrite some scripts for performance (maybe using Rust? We'll see)
- **Eww:** Improve calender widget
- **Swaync:** Trim file
- **Swaync:** Close button offest incorrectly
- **LibreOffice:** Add Java dependency to package rather than "globally"

## Todo
- [ ] Fix and finish all the todos and issues in preparation for a new look :eyes:
- [ ] Complete rice revamp (more cosy: no floating bar, smaller gaps, smaller borders, no rounding)
- [ ] Migrate from Doom Emacs to hand-rolled config (See [here](https://github.com/skiletro/emacs-config))
- [ ] Add a floating compositor (Wayfire looks the most promising)
- [ ] Some sort of wallpaper script/system, probably using [lutgen](https://github.com/ozwaldorf/lutgen-rs)

## Acknowledgements
- [NotAShelf's Nyx Repo](https://github.com/NotAShelf/nyx) - a huge help (also I stole quite a lot of stuff)
- [linkfrg's dotfiles](https://github.com/linkfrg/dotfiles) - was incredibly useful in writing better eww widgets! 

If you can help with any of this stuff, please do a pull request as I am still learning!
