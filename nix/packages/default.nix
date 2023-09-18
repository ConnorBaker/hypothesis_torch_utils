{
  perSystem = {pkgs, ...}: {
    packages.hypothesis_torch_utils = pkgs.python3Packages.callPackage ./hypothesis_torch_utils.nix {};
  };
}
