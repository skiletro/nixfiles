<div align=center>
<h1>nixfiles</h1>
</h2><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="500" />
<p></p>
  <img src="https://img.shields.io/github/stars/skiletro/nixfiles?color=f5c2e7&labelColor=303446&style=for-the-badge&logo=starship&logoColor=f5c2e7">
  <img src="https://img.shields.io/github/repo-size/skiletro/nixfiles?color=fab387&labelColor=303446&style=for-the-badge&logo=github&logoColor=fab387">
 <p></p>
 <img src="https://cdn.discordapp.com/attachments/999330089655345194/1135920400233156739/image.png"></img>
 <p>Screenshot last updated August 1st, 2023</p>
</div>

My dotfiles that I used on my arch-based system can be found [here](https://github.com/skiletro/archfiles), and are a basis for a lot of the configuration here! If you don't use NixOS, you can probably find a more standard config for the thing you are looking for over there.

## Machines
* **Eris** is the name of my desktop computer. Currently it is **not** running NixOS and is therefore missing from this repo
* **Themis** is the name of my laptop, which is a HP Envy X360 13. Currently runs NixOS with almost no flaws

## Installation Guide
- Copy over your `configuration.nix` and `hardware-configuration.nix` to a new folder in `machines/`.
- Rename `configuration.nix` to `default.nix`
- Add the host to the list of hosts in `flake.nix`
- Change all the user references from `jamie` to whatever username you are using
- Run `nix develop --extra-experimental-features "flakes nix-command"` then type `rebuild` (you might need to run it another time for it to fully do its thing)

## Features
* Patched `eww` with [systray support](https://github.com/elkowar/eww/pull/743).
* [Beeper](https://www.beeper.com/) package added

## Todo + Issues
- [ ] **Eww**: Implement notifier for when scratchpad is open (`socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | stdbuf -o0 grep 'workspace>>special' | stdbuf -o0 cut -c1` cmd might be helpful)
- [ ] **Xdg:** Fix programs taking a second or two to load, assumed issue with xdg portals but need to research further
- [ ] **Flake:** Figure out how to move `overlays` from `flake.nix` into a seperate file to keep it "cleaner"
- [ ] **Ricing:** Some sort of wallpaper script/system, prob using [lutgen](https://github.com/ozwaldorf/lutgen-rs)
- [ ] **General:** Seperate settings for `eris` and `themis` (*the latter requires 1.5x scaling whereas the former doesn't need any scaling*)
- [ ] **Fix:** Xdg default applications need to be finished
- [ ] **Flatpak:** Flatpaks need to be declarable (flake is available to do this)

If you can help with any of this stuff, please do a pull request as I am still learning!
