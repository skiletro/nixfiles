self: super: {
    beeper = super.callPackage ./beeper {};
    nvchad = super.callPackage ./nvchad {};
    eww-systray = super.callPackage ./eww-systray {};
}