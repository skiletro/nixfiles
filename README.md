<div align=center>
<h1>nixfiles</h1>
</h2><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="500" />
<p></p>
  <img src="https://img.shields.io/github/stars/skiletro/nixfiles?color=f5c2e7&labelColor=303446&style=for-the-badge&logo=starship&logoColor=f5c2e7">
  <img src="https://img.shields.io/github/repo-size/skiletro/nixfiles?color=fab387&labelColor=303446&style=for-the-badge&logo=github&logoColor=fab387">
 <p></p>
 <img src="https://cdn.discordapp.com/attachments/525406580628258831/1130596467418079414/image.png"></img>
 <p>Screenshot last updated July 17th, 2023</p>
</div>
dotfiles, but nix!

My dotfiles that I used on my arch-based system can be found [here](https://github.com/skiletro/archfiles), and are a basis for a lot of the configuration here! If you don't use NixOS, you can probably find a more standard config for the thing you are looking for over there.


## Installation Guide
- Copy over your `configuration.nix` and `hardware-configuration.nix` to a new folder in `machines/`.
- Rename `configuration.nix` to `default.nix`
- Add the host to the list of hosts in `flake.nix`
- Change all the user references from `jamie` to whatever username you are using
- Run `nix develop --extra-experimental-features flakes --extra-experimental-features nix-command` then type `rebuild` (you might need to run it another time for it to fully do its thing)

## Features
* Patched `eww` with [systray support](https://github.com/elkowar/eww/pull/743).
* [Beeper](https://www.beeper.com/) package added

## Todo
- [ ] Eww bar is still a bit squashed when a long song is playing, as well as a long window title, unsure how to fix as of now
- [ ] Seperate settings for `themis` and (currently non-existant) `eris` as `themis` requires 1.5x scaling with hyprland
- [ ] Fix GTK theme, currently has transparent popups and is using the wrong accent of catppuccin
- [ ] Any sort of `,` in a window title causes the text to be cut off at that point

If you can help with any of this stuff, please do a pull request as I am still learning!
