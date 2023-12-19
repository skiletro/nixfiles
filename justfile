# Local Variables:
# mode: makefile
# End:

# Builds and switches to new system config
switch: pre 
    nh os switch

# Update lockfile, then build and switch to new system config
update: pre
    nh os switch --update

# Formats code, and stages all files
pre:
    alejandra . -q
    git add .

# Run this if nh isn't available (first install?)
no-nh: pre
    sudo nixos-rebuild switch --flake .#