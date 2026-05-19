{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "extras.ai";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.unfree.allowUnfree = [
      "claude-code"
      "cursor"
    ];
  };

  home.ifEnabled = {myconfig, ...}: {
    home.packages = with pkgs; [
      code-cursor
      github-mcp-server
    ];

    programs.nixvim.plugins.claude-code.enable = lib.mkIf myconfig.programs.neovim.enable false;

    programs.claude-code = {
      enable = true;

      mcpServers.github.command = "${pkgs.writeShellScript "github-mcp-wrapper" ''
        export GITHUB_PERSONAL_ACCESS_TOKEN="$(${lib.getExe pkgs.gh} auth token)"
        exec ${lib.getExe pkgs.github-mcp-server} \
          --read-only \
          --toolsets context,discussions,git,issues,pull_requests,repos \
          stdio
      ''}";
    };
  };
}
