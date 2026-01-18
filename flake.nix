{
  inputs = {
    # https://discourse.nixos.org/t/differences-between-nix-channels/13998
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";

    nix-colors.url = "github:misterio77/nix-colors";

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.nix-darwin.follows = "darwin";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      # Locked to this commit temporarily due to:
      # https://github.com/nix-community/nixvim/pull/4025#issuecomment-3615622106
      url = "github:nix-community/nixvim?rev=f15023fcccf34fcae4f86fdaafc576ef027b47e0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {denix, ...} @ inputs: let
    # `mkConfigurations` comes from the upstream `denix` docs without any changes (other
    # than not having a `rices/` directory)
    # https://yunfachi.github.io/denix/configurations/introduction#example
    mkConfigurations = moduleSystem:
      denix.lib.configurations rec {
        inherit moduleSystem;

        homeManagerUser = "ignormies";

        paths = [
          ./hosts
          ./modules
        ];

        specialArgs = {
          inherit inputs moduleSystem homeManagerUser;
        };
      };
  in {
    homeConfigurations = mkConfigurations "home";
    nixosConfigurations = mkConfigurations "nixos";
    darwinConfigurations = mkConfigurations "darwin";
  };
}
