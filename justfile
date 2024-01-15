# Local Variables:
# mode: makefile
# End:

# Builds and switches to new system config
switch: format git-stage-all
    nh os switch

# Update lockfile, then build and switch to new system config
update: format git-stage-all
    nh os switch --update

format:
    alejandra . -q

git-stage-all:
    git add . 
