{
  perSystem = {pkgs, ...}: {
    packages = {
      inherit (pkgs.python3Packages) hypothesis_torch_utils;
    };
  };
}
