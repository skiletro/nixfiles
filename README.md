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

My dotfiles that I used on my arch-based system can be found [here](https://github.com/skiletro/archfiles), and are a basis for a lot of the configuration here! If you don't use NixOS, you can probably find a more standard config for the thing you are looking for over there.

## Machines
* **Eris** is the name of my desktop computer. Currently it is **not** running NixOS and is therefore missing from this repo
* **Themis** is the name of my laptop, which is a HP Envy X360 13. Currently runs NixOS with almost no flaws
* **Vm** is a vm I used to initially test NixOS, but has outgrown its need and will be removed in the future

I also use NixOS under WSL2, but it doesn't use this flake as it's primary/sole purpose is for development flakes

## Installation Guide
- Copy over your `configuration.nix` and `hardware-configuration.nix` to a new folder in `machines/`.
- Rename `configuration.nix` to `default.nix`
- Add the host to the list of hosts in `flake.nix`
- Change all the user references from `jamie` to whatever username you are using
- Run `nix develop --extra-experimental-features flakes --extra-experimental-features nix-command` then type `rebuild` (you might need to run it another time for it to fully do its thing)

## Features
* Patched `eww` with [systray support](https://github.com/elkowar/eww/pull/743).
* [Beeper](https://www.beeper.com/) package added

## Todo + Issues
- [ ] **Repo:** Update screenshot pics
- [ ] **Eww:** Too long of a window title causes the bar to go off the screen
- [ ] **Eww:** `,` symbol in window title causes the text to be cut off at that point
- [ ] **Eww:** Replace swayosd for volume in the same way it has been replaced for brightness
- [ ] **General:** Seperate settings for `eris` and `themis` (*the latter requires 1.5x scaling whereas the former doesn't need any scaling*)
- [ ] **General:** Migrate pc (`eris`) over to NixOS 
- [ ] **GTK:** Catppuccin theme has transparent popups - need to closely monitor [catppuccin/gtk](https://github.com/catppuccin/gtk)
- [ ] **Monitors:** Add shikane - need to monitor hyprlands dodgy/non-standard monitor support
- [ ] **Fix:** Custom `onedrivegui` package at some point. it mumbles on about needing a python pyside6.qt something something
- [ ] **Fix:** xdg default applications need to be finished
- [ ] **Flatpak:** Flatpaks need to be converted to declarative-only (flake is available to do this)

If you can help with any of this stuff, please do a pull request as I am still learning!
