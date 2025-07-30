{...}: {
  programs.nixvim = {
    keymaps = [
      {
        mode = "t";
        key = "jj";
        action = "<C-\\><C-n>";
      }
    ];

    plugins = {
      toggleterm = {
        enable = true;

        settings = {
          open_mapping = "[[<c-\\>]]";
        };
      };
    };
  };
}
