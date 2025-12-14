{delib, ...}:
delib.module {
  name = "programs.neovim";

  home.ifEnabled.programs.nixvim = {
    opts = {
      foldlevelstart = 999; # ~Hack to keep things unfolded on file open
      number = true; # Show line numbers
      relativenumber = true; # Use relative line numbers in gutter
      wrap = false;
    };

    colorschemes.catppuccin = {
      enable = true;

      settings.flavour = "macchiato";
    };
  };
}
