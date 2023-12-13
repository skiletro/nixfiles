# TODO: Add precommit hooks

pre:
    alejandra . -q
    git add .

build: pre
    nh os switch

update: pre
    nh os switch --update
