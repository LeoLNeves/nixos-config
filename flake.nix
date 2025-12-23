{
  description = "Leo's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = 
  { self, nixpkgs, ... }@inputs:
  let
    username = "leo";
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
    };
  };
}
