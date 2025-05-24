[private]
default:
    @just --list --unsorted

[group("rebuild")]
[private]
builder goal *args:
    nix fmt
    git add .
    nh os {{ goal }} -- {{ args }}

[group("rebuild")]
switch *args: (builder "switch" args)

[group("rebuild")]
boot *args: (builder "boot" args)

[group("rebuild")]
test *args: (builder "test" args)

[group("rebuild")]
update *input:
    nix flake update {{ input }} --refresh

[group("housekeeping")]
clean:
    nh clean all -K 1d
    nix store optimise

[group("housekeeping")]
repair:
    nix-store --verify --check-contents --repair
