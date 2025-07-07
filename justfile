[private]
default:
    @just --list --unsorted

[private]
permission:
    @echo -e "\e[35m>\e[0m Retroactively asking for sudo permissions..."
    @sudo true

[group("rebuild")]
[private]
builder goal *args:
    @echo -e "\e[35m>\e[0m Formatting code..."
    @nix fmt
    @echo -e "\e[35m>\e[0m Staging commits..."
    @git add .
    @nh os {{ goal }} -- {{ args }}

[group("rebuild")]
switch *args: (builder "switch" args)

[group("rebuild")]
switch-unattended *args: permission (builder "switch" args)

[group("rebuild")]
boot *args: (builder "boot" args)

[group("rebuild")]
boot-unattended *args: permission (builder "switch" args)

[group("rebuild")]
test *args: (builder "test" args)

[group("rebuild")]
update *input:
    @echo -e "\e[35m>\e[0m Updating flake inputs..."
    @nix flake update {{ input }} --refresh

[group("housekeeping")]
clean:
    @echo -e "\e[35m>\e[0m Cleaning Nix store..." 
    @nh clean all -K 1d
    @echo -e "\e[35m>\e[0m Optimising Nix store..."
    @nix store optimise

[group("housekeeping")]
repair:
    @echo -e "\e[35m>\e[0m Verifying Nix store..."
    @nix-store --verify --check-contents --repair
