# nixfiles
dotfiles, but nix!
My dotfiles that I used on my arch-based system can be found [here](https://github.com/skiletro/archfiles), and are a basis for a lot of the configuration here! If you don't use NixOS, you can probably find a more standard config for the thing you are looking for over there.

## Installation Guide
- Copy over your `configuration.nix` and `hardware-configuration.nix` to a new folder in `machines/`.
- Rename `configuration.nix` to `default.nix`
- Add the host to the list of hosts in `flake.nix`
- Change all the user references from `jamie` to whatever username you are using
- Run `nix develop --extra-experimental-features flakes --extra-experimental-features nix-command` then type `rebuild` (you might need to run it another time for it to fully do its thing)

## Todo
- [ ] Fix cursor issues (tiny and massive cursor for some reason)
- [ ] Fix catppuccin gtk theme
- [ ] Patch eww with system tray support
If you can help with any of this stuff, please do a pull request as I am still learning!
