let
  sources = import ../nix/sources.nix {};

  pkgs = import sources."nixos-21.05" {};
  lib = pkgs.lib;

  mkMachine = hostname: {
    imports = [
      (./machines + "/${hostname}")
      ./roles/all.nix
    ];
    deployment.substituteOnDestination = true;
  };
in
{
  network = {
    inherit pkgs lib;
    description = "hackint.org";
  };

  staging_hub = mkMachine "hub.staging.hackint.org";
  staging_leaf1 = mkMachine "leaf1.staging.hackint.org";
}
