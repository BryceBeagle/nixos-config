{
  inputs = {
    # https://discourse.nixos.org/t/differences-between-nix-channels/13998
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    impermanence.url = "github:nix-community/impermanence";

    nix-colors.url = "github:misterio77/nix-colors";

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
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

        paths = [./hosts ./modules];

        specialArgs = {
          inherit inputs moduleSystem homeManagerUser;
        };
      };
  in {
    nixosConfigurations = mkConfigurations "nixos";
  };
}
