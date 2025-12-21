{
  description = "My system configuration";

  inputs = {
    # main repos
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-legacy.url = "github:nixos/nixpkgs/80d50fc87924c2a0d346372d242c27973cf8cdbf";
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
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixpkgs-legacy, zmod, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    defHost = myHostname: let
      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsLegacy = import nixpkgs-legacy {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsGit = { inherit zmod; };
    in nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs system pkgsUnstable pkgsLegacy pkgsGit myHostname;
      };
      modules = [
        ./nixos/hosts/${myHostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules = [ inputs.nixcord.homeModules.nixcord ];
          system.configurationRevision = self.rev or null;
          system.nixos.label =
            if (self.sourceInfo ? lastModifiedDate) && (self.sourceInfo ? shortRev)
            then "${self.sourceInfo.shortRev}"
            else "${self.sourceInfo.lastModifiedDate}-dirty";
        }
      ] ++ (if myHostname == "lux"
        then [ inputs.sops-nix.nixosModules.sops ]
        else []
      );
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