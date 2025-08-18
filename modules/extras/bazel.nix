{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "extras.bazel";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      # for buildozer/buildifier
      bazel-buildtools
    ];

    programs.nixvim.plugins.lsp.servers = {
      starpls = {
        enable = true;

        cmd = [
          "starpls"
          "server"
          "--experimental_enable_label_completions"
          "--experimental_infer_ctx_attributes"
          "--experimental_use_code_flow_analysis"
        ];
        # Default only specifies bzl, though it seems to work with .bazel files
        # without this config. So I dunno
        # https://github.com/neovim/nvim-lspconfig/blob/612d9fcc/lua/lspconfig/configs/starpls.lua#L6
        filetypes = ["bzl" "bazel"];
      };
    };
  };
}
