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
* **Tyche** is a really low-power VPS from Oracle that I use for misc stuff

## Installation Guide
- Enter a nix-shell with `nix-shell -p alejandra git neovim`
- Clone the repo (preferably under `.nix_config` in your home directory
- Copy over your `configuration.nix` and `hardware-configuration.nix` to a new folder in `machines/`.
- Rename `configuration.nix` to `default.nix`
- Add the host to the list of hosts in `flake.nix`
- Change all the user references from `jamie` to whatever username you are using
- Run `nix develop --extra-experimental-features "flakes nix-command"` then type `rebuild` (you might need to run it another time for it to fully do its thing)

### Example
```bash
nix-shell -p alejandra git neovim
cd ~
git clone https://github.com/skiletro/nixfiles .nix_config
cd .nix_config
mkdir /machines/newsystem
cp /etc/nixos/configuration.nix /machines/newsystem/default.nix
cp /etc/nixos/hardware-configuration.nix /machines/newsystem
nvim flake.nix # Add host to list
nix develop --extra-experimental-features "flakes nix-command"
rebuild # This will take a while, especially if you're using desktop modules
```

## Flake features
* [Beeper](https://www.beeper.com/)
* [lutgen-rs](https://github.com/ozwaldorf/lutgen-rs)
* [NvChad](https://nvchad.com/) - bit dodgy but can be used like [this](https://github.com/skiletro/nixfiles/blob/f2459817670ce5d11a5094ae4b4006e3d52501df/home/neovim/default.nix)


## Todo + Issues
- [ ] **Ricing:** Some sort of wallpaper script/system, prob using [lutgen](https://github.com/ozwaldorf/lutgen-rs)
- [ ] **SwayNC:** Fix little padding/gap issue

If you can help with any of this stuff, please do a pull request as I am still learning!
