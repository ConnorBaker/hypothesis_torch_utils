{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    overlayAttrs = {
      inherit (config.packages) hypothesis_torch_utils;
    };
    packages.hypothesis_torch_utils = pkgs.python3Packages.callPackage ./hypothesis_torch_utils.nix {};
  };
}
