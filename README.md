<pre align="center">
📝: I've had to stop using NixOS for the time being, as my main Linux device (themis) is out of commission.
As a result, this repo won't be updated for a few months. Thanks for your understanding.
</pre>

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
- Wayland First - *Minimal/No X11 if it can be helped*
- Looks Pretty - *A focus on making the system look good to the eyes, without compromising functionality*

## Installation Guide
Please note that this flake is pretty specialised for my use case, and you would probably be better off just stealing the parts you like and then encorporating that into your own flake. This install guide is here **just for reference** (and because I forget how to do this sometimes)

- Install NixOS onto your target system using a [live USB](https://nixos.org/manual/nixos/stable/#sec-booting-from-usb), setting the username to `jamie`
- On your freshly installed system, run `nix-shell -p git neovim`
- Clone this repo into your home directory by typing `git clone https://github.com/skiletro/nixfiles .nix_config`
- `cd ~/.nix_config`
- `mkdir hosts/<HOSTNAME>`
- `cp /etc/nixos/confguration.nix hosts/<HOSTNAME>/default.nix`
- `cp /etc/nixos/hardware-configuration.nix hosts/<HOSTNAME>/`
- Edit `hosts/<HOSTNAME>/default.nix` and change the networking hostname to your `<HOSTNAME>`. You can also edit this file for your specific changes
- Add a new entry for your new hostname under `nixosConfigurations` in `flake.nix`
- `nix develop --extra-experimental-features "flakes nix-command"`
- `just format` to make sure everything is formatted correctly and it won't error out
- `git add .`
- `sudo nixos-rebuild switch --flake .#<HOSTNAME>`
- Let it complete, and you're done! You'll probably want to reboot too

## Custom Modules Layout
<details>
  <summary>Click here to reveal</summary>
  <pre>
.
├── greeter
│   ├── enable (bool)
│   └── type (enum)
├── desktop
│   ├── enable (bool)
│   ├── environments (list, enum)
│   ├── terminalEmulator (enum)
│   ├── scaling
│   │   ├── enable (bool)
│   │   └── multiplier (float)
│   └── isWayland (not set manually)
├── programs
│   ├── graphical
│   │   ├── enable (bool, enables the rest of graphical and terminal)
│   │   ├── gaming (bool)
│   │   ├── emacs (bool)
│   │   ├── firefox (bool)
│   │   ├── spotify (bool)
│   │   └── zathura (bool)
│   ├── terminal
│   │   ├── neovim (bool)
│   │   ├── utils (bool)
│   │   └── extras (bool)
│   └── services
│       ├── eww (bool)
│       ├── swaylock (bool)
│       ├── swaync (bool)
│       ├── syncthing (bool)
│       └── wlogout (bool)
└── virtualisation
    └── enable (bool)
  </pre>
</details>

## Issues
- **LibreOffice:** Add Java dependency to package rather than "globally"

## Todo
- [ ] Speed up Emacs start times
- [ ] Some sort of wallpaper script/system, probably using [lutgen](https://github.com/ozwaldorf/lutgen-rs)

## Acknowledgements
- [NotAShelf's Nyx Repo](https://github.com/NotAShelf/nyx) - a huge help (also I stole quite a lot of stuff)
- [linkfrg's dotfiles](https://github.com/linkfrg/dotfiles) - was incredibly useful in writing better eww widgets! 

If you can help with any of this stuff, please do a pull request as I am still learning!
