self: super: {
    beeper = super.callPackage ./beeper {};
    nvchad = super.callPackage ./nvchad {};
}