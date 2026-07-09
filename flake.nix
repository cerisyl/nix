{
  description = "My system configuration";

  inputs = {
    # main repos
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # extra programs + home-manager
    sops-nix.url = "github:Mic92/sops-nix";
    nixcord = {
      url = "github:KaylorBen/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zmod = {
      url = "github:zarzob/Simply-Love-SM5/itgmania-release";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, zmod, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    defHost = myHostname: let
      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsGit = { inherit zmod; };
      libutils = import ./nixos/utils.nix { inherit (nixpkgs) lib; };
    in nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs system libutils pkgsUnstable pkgsGit myHostname;
      };
      modules = [
        ./nixos/hosts/${myHostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops
        {
          home-manager.sharedModules = [ inputs.nixcord.homeModules.nixcord ];
          system.configurationRevision = self.rev or null;
          system.nixos.label =
            if (self.sourceInfo ? lastModifiedDate) && (self.sourceInfo ? shortRev)
            then "${self.sourceInfo.shortRev}"
            else "${self.sourceInfo.lastModifiedDate}-dirty";
        }
      ];
    };
  in {
    nixosConfigurations = {
      lux     = defHost "lux";
      nova    = defHost "nova";
      astore  = defHost "astore";
      medea   = defHost "medea";
      vm      = defHost "vm";
      engrit  = defHost "engrit";
    };
  };
}
