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
- Run `nix develop --extra-experimental-features flakes --extra-experimental-features nix-command` then type `rebuild` (you might need to run it another time for it to fully do its thing)

## Features
* Patched `eww` with [systray support](https://github.com/elkowar/eww/pull/743).
* [Beeper](https://www.beeper.com/) package added

## Todo + Issues
- [ ] ⚠️ Need to fix 20s delay when launching gtkgreet from cage
- [ ] Format markdown correctly in `overlays/` and `packages/`
- [ ] Figure out how to move `overlays` from `flake.nix` into a seperate file to keep it "cleaner"
- [ ] Migrate over to AGS from EWW - has better scaling support
- [ ] Get plymouth up and running (prob remove tty themeing)
- [ ] Some sort of wallpaper script/system, prob using [lutgen](https://github.com/ozwaldorf/lutgen-rs)
- [ ] **Eww:** Fix issue with custom OSD where it flickers, need to fix `osd` script (need to look into ags reimplementation too, see above)
- [ ] Evaluate if 1.5x scaling on `themis` is adequate or if I can get away with a smaller scale
- [ ] **General:** Seperate settings for `eris` and `themis` (*the latter requires 1.5x scaling whereas the former doesn't need any scaling*)
- [ ] **General:** Migrate pc (`eris`) over to NixOS (prob not gonna happen anytime soon due to lackluster VR and Nvidia GPU support)
- [ ] **GTK:** Catppuccin theme has transparent popups - need to closely monitor [catppuccin/gtk](https://github.com/catppuccin/gtk)
- [ ] **Monitors:** Add shikane - need to monitor hyprlands dodgy/non-standard monitor support
- [ ] **Fix:** xdg default applications need to be finished
- [ ] **Flatpak:** Flatpaks need to be converted to declarative-only (flake is available to do this)

If you can help with any of this stuff, please do a pull request as I am still learning!
