# nixfiles
nix dotfiles based on bezmuth

## their install guide (will upd8 soon)
Run `nix-develop` in this directory then run `rebuild`

### I WANNA USE THIS
okay that's nice, first you're gonna have to change a couple of things
- add a folder in the machines dir with hardware-configuration and a default.nix (or just a default.nix with the hardware config)
- add this host to the host list in flake.nix
- change all the references from ~~bezmuth~~jamie to whatever username you wanna use (home dir n stuff)