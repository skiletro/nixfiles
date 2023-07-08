self: super: {
    beeper = super.callPackage ./beeper {};
    nvchad = super.callPackage ./nvchad {};
    eww = super.callPackage ./eww-systray {};
}