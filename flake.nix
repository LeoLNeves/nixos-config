{
  description = "Leo's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    personal_website.url = "github:LeoLNeves/personal_website";
    personal_website.flake = false;
  };

  outputs = 
  { self, nixpkgs, personal_website, ... }@inputs:
  let
    username = "leo";
    domain = "leonardoneves.com";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system; # Use the specified system
      config.allowUnfree = true; # Allow proprietary software
    };
    lib = nixpkgs.lib;
  in
  {
    nixosConfigurations = {
      shire = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/shire
        ];
        specialArgs = {
          host = "shire";
          inherit self inputs username;
        };
      };

      isengard = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/isengard
          inputs.disko.nixosModules.disko
        ];
        specialArgs = {
          host = "isengard";
          inherit self inputs username domain personal_website;
        };
      };

      virtus = lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/virtus
        ];
        specialArgs = {
          host = "virtus";
          inherit self inputs username;
        };
      };
    };
  };
}
